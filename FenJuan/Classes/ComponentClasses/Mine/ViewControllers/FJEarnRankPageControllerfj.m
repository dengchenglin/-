//
//  CTEarnRankPageController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/13.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJEarnRankPageControllerfj.h"
#import "LMSegmentedControl.h"
#import "FJEarnRankHeadViewfj.h"
#import "FJEarnRankViewControllerfj.h"
#import "FJEarnRankNavBarfj.h"
#import "CTNetworkEngine+Member.h"
#import "FJEarnRankModelfj.h"

@interface FJEarnRankPageControllerfj ()<LMSegmentedControlDelegate>

@property (nonatomic, strong) FJEarnRankNavBarfj *navBar;
@property (nonatomic, copy) NSArray <CTNestSubControllerProtocol>*_viewControllers;
@property (nonatomic, strong) FJEarnRankHeadViewfj *rankHeadView;
@property (nonatomic, strong) LMSegmentedControl *segmentedControl;
@property (nonatomic, strong) FJEarnRankModelfj *model;

@end

@implementation FJEarnRankPageControllerfj

- (FJEarnRankHeadViewfj *)rankHeadView{
    if(!_rankHeadView){
        _rankHeadView = NSMainBundleClass(FJEarnRankHeadViewfj.class);
        _rankHeadView.backgroundColor = [UIColor brownColor];
    }
    return _rankHeadView;
}

- (LMSegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        _segmentedControl = [[LMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.heightForSuspendView)];
        _segmentedControl.delegate = self;
        _segmentedControl.backgroundColor = RGBColor(64, 42, 204);
        _segmentedControl.segmentedControlType = LMSegmentedControlScreen;
        _segmentedControl.selectedLineWidth = 26;
        _segmentedControl.selectedLineHeight = 4;
        _segmentedControl.selectedLineColor = HexColor(@"#FFC726");
        _segmentedControl.titleNormalColor = RGBColor(207, 199, 255);
        _segmentedControl.titleSelectedColor = [UIColor whiteColor];
        _segmentedControl.titles = @[@"昨日返利",@"本月返利",@"上月返利",@"总返利"];
    }
    return _segmentedControl;
}

- (FJEarnRankNavBarfj *)navBar{
    if(!_navBar){
        _navBar = NSMainBundleClass(FJEarnRankNavBarfj.class);
        _navBar.titleLabel.text = @"返利排行榜";
        _navBar.backgroundAlpha = 0;
    }
    return _navBar;
}


- (NSArray<UIViewController *> *)_viewControllers{
    if(!__viewControllers){
        NSMutableArray *array = [NSMutableArray array];
        for(int i = 0;i < 4;i ++){
            FJEarnRankViewControllerfj *vc = [[FJEarnRankViewControllerfj alloc]init];
            [array addObject:vc];
        }
        __viewControllers = [array copy];
    }
    return __viewControllers;
}


- (NSArray <CTNestSubControllerProtocol>*)viewControllers{
    return self._viewControllers;
}

- (CGFloat)heightForHeadView{
    return SCREEN_WIDTH/2.1;
}

- (UIView *)headView{
    return self.rankHeadView;
}


- (CGFloat)heightForSuspendView{
    return 40;
}

- (UIView *)suspendView{

    return self.segmentedControl;
}

- (void)pageViewControllerDidScrollToIndex:(NSInteger)index{
    [self.segmentedControl scrollToIndex:index];
}


- (void)setUpUI{
    self.hideSystemNavBarWhenAppear = YES;
    [self.view addSubview:self.navBar];
}
- (void)autoLayout{
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(0);
        make.height.mas_equalTo(NAVBAR_HEIGHT);
    }];
}



- (void)setUpEvent{
    @weakify(self)
    [self.scrollView addHeaderRefreshWithCallBack:^{
        @strongify(self)
        [self request];
    }];
    [self.navBar.backButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [self back];
    }];
}
- (void)request{
    [CTRequest fj_icomenRankWithCallback:^(id data, CLRequest *request, CTNetError error) {
        [self.scrollView endRefreshing];
        self.model = [FJEarnRankModelfj yy_modelWithDictionary:data];
        for(int i = 0;i < self.viewControllers.count;i ++){
            FJEarnRankViewControllerfj *vc = self.viewControllers[i];
            switch (i) {
                case 0:{
                    vc.models = _model.yesterday;
                }
                    break;
                case 1:{
                    vc.models = _model.month;
                }
                    break;
                case 2:{
                    vc.models = _model.last_month;
                }
                    break;
                case 3:{
                    vc.models = _model.all;
                }
                    break;
                default:
                    break;
            }
        }
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [super scrollViewDidScroll:scrollView];
    if(scrollView == self.scrollView){
        if(self.scrollView.contentOffset.y > 0){
            CGFloat offestY = self.heightForHeadView - (self.ignoreNavBar?0:NAVBAR_HEIGHT);
            _navBar.backgroundAlpha = self.scrollView.contentOffset.y/offestY;
        }
        else{
            _navBar.backgroundAlpha = 0.0;
        }
    }
}


#pragma mark - LMSegmentControlDelegate
- (void)segmentedControl:(LMSegmentedControl *)segmentedControl didSelectedInbdex:(NSUInteger)index{
    [self pageViewControllerScrollToIndex:index];
}
@end
