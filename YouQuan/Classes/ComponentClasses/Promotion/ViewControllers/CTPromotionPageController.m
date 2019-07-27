//
//  CTPromotionPageController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTPromotionPageController.h"
#import "LMSegmentedControl.h"
#import "CTOneGoodListViewController.h"
#import "CTMultipleGoodListViewController.h"
#import "CTMaterialListViewController.h"
@interface CTPromotionPageController ()<LMSegmentedControlDelegate>
@property (nonatomic, strong) LMSegmentedControl *segmentedControl;
@end

@implementation CTPromotionPageController
- (LMSegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        _segmentedControl = [[LMSegmentedControl alloc]init];
        _segmentedControl.delegate = self;
        _segmentedControl.titleNormalColor = [UIColor whiteColor];
        _segmentedControl.titleSelectedColor = [UIColor whiteColor];
        _segmentedControl.silderStyle = LMSegmentedControlSilderSquare;
        _segmentedControl.selectedLineWidth = 88;
        _segmentedControl.selectedLineHeight = 29;
        _segmentedControl.selectedLineColor = RGBColor(255, 199, 38);
        _segmentedControl.backgroundImage = [UIImage imageNamed:@"pic_nav_bg"];
    }
    return _segmentedControl;
}

- (void)setUpUI{
    self.title = @"发圈";
    [self.view addSubview:self.segmentedControl];
//    self.segmentedControl.titles = @[@"每日单品",@"多品推荐",@"宣传素材"];
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[CTOneGoodListViewController new]];
//    [array addObject:[CTMultipleGoodListViewController new]];
//    [array addObject:[CTMaterialListViewController new]];
    self.viewControllers = array;

}
- (void)autoLayout{
//    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(48);
//    }];
//    self.contentInsets = UIEdgeInsetsMake(48, 0, 0, 0);
}

//- (void)segmentedControl:(LMSegmentedControl *)segmentedControl didSelectedInbdex:(NSUInteger)index{
//    [self scrollToIndex:index];
//}
//
//- (void)pageController:(CTPageController *)pageController didScrollToIndex:(NSInteger)index{
//    [self.segmentedControl scrollToIndex:index];
//}
@end
