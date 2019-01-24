//
//  CTBaseViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

@interface CTBaseViewController ()

@property (nonatomic, strong) UIView *autoLayoutContainerView;

@end

@implementation CTBaseViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    CTBaseViewController *viewController = [super allocWithZone:zone];
    [viewController initialize];
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController setUpUI];
        [viewController autoLayout];
        [viewController request];
        [viewController reloadView];
        [viewController setUpEvent];
        [viewController bindViewModel];
    }];
    [[viewController rac_signalForSelector:@selector(viewDidLayoutSubviews)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController frameLayout];
    }];
    
    return viewController;
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return _navigationBarStyle==CTNavigationBarRed?UIStatusBarStyleLightContent:UIStatusBarStyleDefault;
}


- (UIView *)autoLayoutContainerView{
    if(!_autoLayoutContainerView){
        _autoLayoutContainerView = [[UIView alloc]init];
        if(_scrollViewAvailable){
            if(!_scrollView){
                _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
       
            }
            [_scrollView addSubview:_autoLayoutContainerView];
            [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(self.view);
            }];
            [_autoLayoutContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.mas_equalTo(self.scrollView);
                make.width.mas_equalTo(self.scrollView);
            }];
        }
    }
    return _autoLayoutContainerView;
}

- (void)setScrollViewAvailable:(BOOL)scrollViewAvailable{
    _scrollViewAvailable = scrollViewAvailable;
    if(!self.viewLoaded)return;
    if(!_scrollView)
    {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];

        _scrollView.contentSize = CGSizeMake(self.view.width, self.view.height + 10);
        _scrollView.delegate = (id<UIScrollViewDelegate>)self;
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
        
        if (@available(iOS 11.0, *)) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
    }
    
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)setHideNavBarBottomLine:(BOOL)hideNavBarBottomLine{
    _hideNavBarBottomLine = hideNavBarBottomLine;
    if(_hideNavBarBottomLine){
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
    else{
        [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:RGBColor(240, 240, 240)]];
    }
}
- (void)setNavigationBarStyle:(CTNavigationBarStyle)navigationBarStyle{
    _navigationBarStyle = navigationBarStyle;
    if(_navigationBarStyle == CTNavigationBarRed){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"pic_nav_bg"] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:CTCoarseFont(20)}];
        UIButton *backButton = self.navigationItem.leftBarButtonItem.customView;
        if(backButton){
            UIImage *newImage = [[UIImage imageNamed:@"ic_return"] imageWithColor:[UIColor whiteColor]];
            [backButton setImage:newImage forState:UIControlStateNormal];
        }
    }
    else if(_navigationBarStyle == CTNavigationBarWhite){
         [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#141414"],NSFontAttributeName:CTCoarseFont(20)}];
        UIButton *backButton = self.navigationItem.leftBarButtonItem.customView;
        if(backButton){
            UIImage *newImage = [UIImage imageNamed:@"ic_return"];
            [backButton setImage:newImage forState:UIControlStateNormal];
        }
    }
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#141414"],NSFontAttributeName:CTCoarseFont(22)}];
    if([self.navigationController.viewControllers indexOfObject:self] > 0){
        self.edgesForExtendedLayout = UIRectEdgeBottom;
      
    }
    else{
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self configureNavBar];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:_hideSystemNavBarWhenAppear animated:YES];
    self.hideNavBarBottomLine = _hideNavBarBottomLine;
    self.navigationBarStyle = _navigationBarStyle;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.didAppear = YES;
}


- (void)setLeftDefaultItem{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 40, 30)];
    [backBtn setImage:[UIImage imageNamed:@"ic_return"] forState:UIControlStateNormal];
    backBtn.imageView.contentMode = UIViewContentModeCenter;
    [backBtn setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    backBtn.titleLabel.font = FONT_PFRG_SIZE(15);
    UIBarButtonItem * item =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = item;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    if(IOS_11){
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(backBtn.size);
        }];
    }
}

- (UIButton *)setRightButtonWithImageName:(NSString *)imageName selector:(SEL)selector{
    return [self setRightButtonWithImageName:imageName size:CGSizeZero selector:selector];
}

- (UIButton *)setRightButtonWithTitle:(NSString *)title  selector:(SEL)selector{
    return  [self setRightButtonWithTitle:title titleColor:nil  selector:selector];
}

- (UIButton *)setRightButtonWithImageName:(NSString *)imageName size:(CGSize)size selector:(SEL)selector{
    return  [self setRightButtonWithImageName:imageName size:size imageEdgeInsets:UIEdgeInsetsZero selector:selector];
}

- (UIButton *)setRightButtonWithImageName:(NSString *)imageName imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets selector:(SEL)selector{
    return  [self setRightButtonWithImageName:imageName size:CGSizeZero imageEdgeInsets:imageEdgeInsets selector:selector];
}

- (UIButton *)setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor selector:(SEL)selector{
    CGSize size = CGSizeZero;
    if(title.length){
        size = [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(100, 15)];
        size.width += 1;
    }
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, size.width, size.height)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:(titleColor?titleColor:RGBColor(102, 102, 102)) forState:UIControlStateNormal];
    
    if(selector){
        [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    if(IOS_11){
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
        }];
    }
    return button;
}



- (UIButton *)setRightButtonWithImageName:(NSString *)imageName size:(CGSize)size imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets selector:(SEL)selector{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    if(size.width == 0 || size.height == 0){
        size = CGSizeMake(30, 30);
    }
    if(!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, imageEdgeInsets)){
        button.imageEdgeInsets = imageEdgeInsets;
    }
    [button setFrame:CGRectMake(0, 0, size.width, size.height)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    UIBarButtonItem * item =[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    if(IOS_11){
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(button.size);
        }];
    }
    return button;
}

- (void)configureNavBar{
    self.hideNavBarBottomLine = YES;
    

    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:RGBColor(240, 240, 240)]];
    
    if(self.navigationController.viewControllers.count > 1){
        [self setLeftDefaultItem];
    }
    else{
        self.navigationItem.leftBarButtonItem = nil;
    }
    
}



- (void)back{
    if(self.navigationController.viewControllers.count > 1){
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    [self.view endEditing:YES];
}

- (void)setShowBackItem:(BOOL)showBackItem{
    _showBackItem = showBackItem;
    if(_showBackItem){
        [self setLeftDefaultItem];
    }
    else{
        self.navigationItem.leftBarButtonItem = nil;
    }
}
- (void)initialize{}

- (void)setUpUI{}

- (void)reloadView{}

- (void)request{}

- (void)autoLayout{}

- (void)frameLayout{}

- (void)setUpEvent{}

- (void)bindViewModel{}

- (void)reloadData:(id)data{};


@end
