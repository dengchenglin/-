//
//  CTReconmendViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTRecommendViewController.h"

#import "LMSegmentedControl.h"

@interface CTRecommendViewController ()<LMSegmentedControlDelegate>

@property (nonatomic, strong) LMSegmentedControl *segmentedControl;

@end

@implementation CTRecommendViewController


- (LMSegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        _segmentedControl = [[LMSegmentedControl alloc]init];
        _segmentedControl.delegate = self;
        _segmentedControl.titleNormalColor = RGBColor(255, 204, 190);
        _segmentedControl.titleSelectedColor = [UIColor whiteColor];
        _segmentedControl.silderStyle = LMSegmentedControlSilderSquare;
        _segmentedControl.selectedLineWidth = 88;
        _segmentedControl.selectedLineHeight = 29;
        _segmentedControl.selectedLineColor = RGBColor(255, 199, 38);
        
    }
    return _segmentedControl;
}

- (void)setUpUI{
    self.navigationItem.titleView = self.segmentedControl;
    self.contentInsets = UIEdgeInsetsMake(0, 0, TABBAR_HEIGHT, 0);
}

- (void)autoLayout{
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 40, 44));
    }];
}
- (void)reloadView{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.segmentedControl.titles = @[@"官方精选",@"视频购",@"整点抢购"];
    });
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[[CTModuleManager goodListService] handpickShopViewController]];
    [array addObject:[[CTModuleManager goodListService] videoShopViewController]];
    [array addObject:[[CTModuleManager goodListService] spreeShopViewController]];
    self.viewControllers = array;
}

- (void)segmentedControl:(LMSegmentedControl *)segmentedControl didSelectedInbdex:(NSUInteger)index{
    [self scrollToIndex:index];
}
- (void)pageController:(CTPageController *)pageController didScrollToIndex:(NSInteger)index{
    [self.segmentedControl scrollToIndex:index];
}


@end
