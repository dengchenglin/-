//
//  CTHomeTopView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeTopView.h"

#import "CTMainCategoryHeadView.h"


@interface CTCategoryModalView:UIView

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIImageView *backgroundView;

@property (nonatomic, strong) CTMainCategoryView *categoryView;

@property (nonatomic, copy) NSArray <CTCategoryModel *>*categoryModels;

- (void)show;

- (void)hide;

@end

@implementation CTCategoryModalView

ViewInstance(setUp)

- (void)setUp{

    _backgroundView = [[UIImageView alloc]init];

    _backgroundView.backgroundColor = [UIColor blackColor];
    [self addSubview:_backgroundView];
    _containerView = [UIView new];
    _containerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_containerView];
    _categoryView = [[CTMainCategoryView alloc]init];
    [self addSubview:_categoryView];
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [_categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
    }];
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
}

- (void)setCategoryModels:(NSArray<CTCategoryModel *> *)categoryModels{
    _categoryModels = [categoryModels copy];
    _categoryView.categoryModels = _categoryModels;
    CGFloat height = [CTMainCategoryView heightForCategoryCount:_categoryModels.count];
    [_categoryView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-height);
    }];
    [self layoutIfNeeded];
}

- (void)show{
    self.hidden = NO;
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:5 initialSpringVelocity:30 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.backgroundView.alpha = 0.5;
        [self.categoryView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
        }];
        [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.categoryView.height);
        }];
        [self layoutIfNeeded];
    } completion:nil];
}


- (void)hide{
    self.hidden = YES;
    self.backgroundView.alpha = 0;
    [self.categoryView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-self.categoryView.height);
    }];
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    [self layoutIfNeeded];
}
@end

@interface CTHomeTopView()<LMSegmentedControlDelegate>

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, weak) CTMainCategoryHeadView *categoryHeadView;

@property (nonatomic, weak) UIViewController *superViewController;

@property (nonatomic, weak) CTCategoryModalView *categoryModalView;

@end

@implementation CTHomeTopView{
    BOOL _unfolded;
}

ViewInstance(setUp)


- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if(newSuperview){
        _superViewController = [UIUtil getCurrentViewController];
    }
}

- (CTMainCategoryHeadView *)categoryHeadView{
    if(!_categoryHeadView){
        CTMainCategoryHeadView *headView = NSMainBundleClass(CTMainCategoryHeadView.class);
        headView.alpha = 0;
        _categoryHeadView = headView;
        [self.categoryControl addSubview:headView];
        [headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return _categoryHeadView;
}

- (CTCategoryModalView *)categoryModalView{
    if(!_categoryModalView && _superViewController){
        CTCategoryModalView *categoryModalView = [[CTCategoryModalView alloc]init];
        categoryModalView.hidden = YES;
        [self.superViewController.view insertSubview:categoryModalView belowSubview:self];
        
        [categoryModalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_bottom);
            make.left.right.bottom.mas_equalTo(0);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideModalView)];
        categoryModalView.backgroundView.userInteractionEnabled = YES;
        [categoryModalView.backgroundView addGestureRecognizer:tap];
        _categoryModalView = categoryModalView;
        
        @weakify(self)
        [_categoryModalView.categoryView setClickItemBlock:^(NSInteger index) {
            @strongify(self)
            if(self.clickCategoryBlock){
                self.clickCategoryBlock(index);
            }
            [self.categoryControl.segmentedControl scrollToIndex:index];
            [self hideModalView];
        }];
    }
    return _categoryModalView;
}


- (void)setUp{
    [self setUpUI];
    [self autoLayout];
    [self setUpEvent];
}
- (void)setUpUI{
    _containerView = [UIView new];
    _containerView.layer.contents = (__bridge id)[UIImage imageNamed:@"pic_nav_bg"].CGImage;
    [self addSubview:_containerView];
    
    _navBar = NSMainBundleClass(CTHomeNavBar.class);
    [_containerView addSubview:_navBar];
    
    _categoryControl = [[CTMainCategoryControl alloc]init];
    _categoryControl.segmentedControl.delegate = self;
    _categoryControl.backgroundColor = [UIColor clearColor];
    [_containerView addSubview:_categoryControl];
}
- (void)autoLayout{
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(NAVBAR_HEIGHT);

    }];
    [_categoryControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navBar.mas_bottom);
        make.bottom.left.right.mas_equalTo(0);
    }];
}
- (void)setUpEvent{
    @weakify(self)
    [self.categoryControl.unfoldButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(self->_unfolded){
            [self hideModalView];
            self->_unfolded = NO;
        }
        else{
           self->_unfolded = [self showModalView];
        }
    }];
    [self.categoryHeadView.closeButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [self hideModalView];
    }];
}

- (BOOL)showModalView{
    self.categoryHeadView.alpha = 1.0;
    [self.categoryModalView show];
    return YES;
}
- (void)hideModalView{
    self.categoryHeadView.alpha = 0.0;
    self->_unfolded = NO;
    [self.categoryModalView hide];
}

- (void)setCategoryModels:(NSArray<CTCategoryModel *> *)categoryModels{
    _categoryModels = [categoryModels copy];
    _categoryControl.categoryModels = _categoryModels;
    self.categoryModalView.categoryModels = _categoryModels;
}


#pragma mark -LMSegmentedControlDelegate
- (void)segmentedControl:(LMSegmentedControl *)segmentedControl didSelectedInbdex:(NSUInteger)index{
    if(self.clickCategoryBlock){
        self.clickCategoryBlock(index);
    }
}

@end
