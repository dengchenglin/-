
//
//  CTMyTeamPageController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMyTeamPageController.h"

#import "LMSegmentedControl.h"

#import "CTTeamListViewController.h"

#import "CTNetworkEngine+Member.h"

#import "CTTeamCateModel.h"

@interface CTMyTeamPageController ()<LMSegmentedControlDelegate>
@property (nonatomic, strong) LMSegmentedControl *segmentedControl;
@property (nonatomic, strong) CTTeamCateModel *model;
@end

@implementation CTMyTeamPageController

- (LMSegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        _segmentedControl = [[LMSegmentedControl alloc]init];
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.delegate = self;
        _segmentedControl.segmentedControlType = LMSegmentedControlScreen;
        _segmentedControl.selectedLineWidth = 26;
        _segmentedControl.selectedLineHeight = 4;
        _segmentedControl.selectedLineColor = HexColor(@"#FFC726");
        _segmentedControl.titleNormalColor = RGBColor(80, 80, 80);
        _segmentedControl.titleSelectedColor = RGBColor(20, 20, 20);

    }
    return _segmentedControl;
}

- (void)setUpUI{
    self.title = @"我的团队";
    self.hideNavBarBottomLine = YES;
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.segmentedControl];
    self.contentInsets = UIEdgeInsetsMake(45, 0, 0, 0);
}

- (void)autoLayout{
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
}
- (void)request{
    [CTRequest teamCateWithCallback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
             self.model =  [CTTeamCateModel yy_modelWithDictionary:data];
            [self reloadView];
        }
    }];
}


- (void)reloadView{
    if(!self.model)return;
    NSMutableArray <CTTeamCateItem *>*array = [NSMutableArray array];
    if(self.model.all){
        [array addObject:self.model.all];
    }
    if(self.model.directly){
        [array addObject:self.model.directly];
    }
    if(self.model.indirect){
        [array addObject:self.model.indirect];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _segmentedControl.titles = [array map:^id(NSInteger index, CTTeamCateItem *element) {
            return element.txt?:@"";
        }];
    });
    NSMutableArray *vcs = [NSMutableArray array];
    for(int i = 0;i < array.count;i ++){
        CTTeamListViewController *vc = [[CTTeamListViewController alloc]init];
        vc.cateId = array[i].cate_id;
        [vcs addObject:vc];
    }
    self.viewControllers = vcs;
}

- (void)segmentedControl:(LMSegmentedControl *)segmentedControl didSelectedInbdex:(NSUInteger)index{
    [self scrollToIndex:index];
}
- (void)pageController:(CTPageController *)pageController didScrollToIndex:(NSInteger)index{
    [self.segmentedControl scrollToIndex:index];
}

@end
