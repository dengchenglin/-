//
//  CTBaseViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

@interface CTScrollView()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL scrollViewAllowMultiGes;

@end
@implementation CTScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if(_scrollViewAllowMultiGes){
      return YES;
    }
    return NO;
}

@end

@interface CTBaseViewController ()

@property (nonatomic, strong) UIView *autoLayoutContainerView;

@property (nonatomic, assign) BOOL requested;

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
        [viewController reloadView];
        [viewController setUpEvent];
        [viewController bindViewModel];
    }];
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        @strongify(viewController)
        if(!viewController.requested){
            [viewController request];
            viewController.requested = YES;
        }
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
                _scrollView = [[CTScrollView alloc]initWithFrame:self.view.bounds];
                
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
- (void)setScrollViewAllowMultiGes:(BOOL)scrollViewAllowMultiGes{
    _scrollViewAllowMultiGes = scrollViewAllowMultiGes;
    if(_scrollView){
       _scrollView.scrollViewAllowMultiGes = _scrollViewAllowMultiGes;
    }
}

- (void)setScrollViewAvailable:(BOOL)scrollViewAvailable{
    _scrollViewAvailable = scrollViewAvailable;
    if(!self.viewLoaded)return;
    if(!_scrollView)
    {
        _scrollView = [[CTScrollView alloc]initWithFrame:self.view.bounds];
        
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
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"p_nav_bg"] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:CTCoarseFont(20)}];
        UIButton *backButton = self.navigationItem.leftBarButtonItem.customView;
        if(backButton){
            UIImage *newImage = [[UIImage imageNamed:@"i_return"] imageWithColor:[UIColor whiteColor]];
            [backButton setImage:newImage forState:UIControlStateNormal];
        }
    }
    else if(_navigationBarStyle == CTNavigationBarWhite){
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#141414"],NSFontAttributeName:CTCoarseFont(20)}];
        UIButton *backButton = self.navigationItem.leftBarButtonItem.customView;
        if(backButton){
            UIImage *newImage = [UIImage imageNamed:@"i_return"];
            [backButton setImage:newImage forState:UIControlStateNormal];
        }
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    {
        self.ls_qia_qia = @"sss";
        self.sx_cp_ll = [UILabel new];
        self.io_to_ro = 10;
        self.si_ni_io = 2;
        self.is_lo_in = @"hehe";
    }
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
   self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    if(self.hideSystemNavBarWhenAppear){
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
    else{
        self.edgesForExtendedLayout = UIRectEdgeLeft|UIRectEdgeBottom|UIRectEdgeRight;
    }
    [self configureNavBar];
    for(int i = 0;i < arc4random()%2;i++){
        UIView *v = [UIView new];
        [self.view insertSubview:v atIndex:0];
    }
}



- (void)configureNavBar{
    self.hideNavBarBottomLine = YES;
    self.navigationBarStyle = _navigationBarStyle;
    
    self.navigationController.navigationBar.translucent = NO;
    if(self.navigationController.viewControllers.count > 1){
        [self setLeftDefaultItem];
    }
    else{
        self.navigationItem.leftBarButtonItem = nil;
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    BOOL lastNavBarHidden = self.navigationController.navigationBarHidden;
    [super viewWillAppear:animated];
    if(self.isPop){
        //如果发起push的控制器的导航是隐藏的就不要动画
        [self.navigationController setNavigationBarHidden:_hideSystemNavBarWhenAppear animated:!lastNavBarHidden];
    }
    else{
        [self.navigationController setNavigationBarHidden:_hideSystemNavBarWhenAppear animated:NO];
    }
    
    self.hideNavBarBottomLine = _hideNavBarBottomLine;
    self.navigationBarStyle = _navigationBarStyle;
    
}



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.didAppear = YES;
    if(self.navigationController.viewControllers.firstObject == self){
      self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        
    }
}


- (void)setLeftDefaultItem{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 40, 30)];
    [backBtn setImage:[UIImage imageNamed:@"i_return"] forState:UIControlStateNormal];
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
    return  [self setRightButtonWithTitle:title font:nil  titleColor:nil  selector:selector];
}

- (UIButton *)setRightButtonWithImageName:(NSString *)imageName size:(CGSize)size selector:(SEL)selector{
    return  [self setRightButtonWithImageName:imageName size:size imageEdgeInsets:UIEdgeInsetsZero selector:selector];
}

- (UIButton *)setRightButtonWithImageName:(NSString *)imageName imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets selector:(SEL)selector{
    return  [self setRightButtonWithImageName:imageName size:CGSizeZero imageEdgeInsets:imageEdgeInsets selector:selector];
}

- (UIButton *)setRightButtonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor selector:(SEL)selector{
    CGSize size = CGSizeZero;
    if(!font)font = [UIFont systemFontOfSize:15];
    if(title.length){
        size = [title sizeWithFont:font constrainedToSize:CGSizeMake(100, 15)];
        size.width += 1;
    }
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, size.width, size.height)];
    button.titleLabel.font = font;
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
