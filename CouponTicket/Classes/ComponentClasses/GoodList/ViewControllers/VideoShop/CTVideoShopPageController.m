//
//  CTVideoShopPageController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTVideoShopPageController.h"

#import "LMSegmentedControl.h"

#import "CTVideoShopListViewController.h"

@interface CTVideoShopPageController ()<LMSegmentedControlDelegate>

@property (nonatomic, strong) LMSegmentedControl *segmentedControl;

@end

@implementation CTVideoShopPageController

- (LMSegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        _segmentedControl = [[LMSegmentedControl alloc]init];
        _segmentedControl.delegate = self;
        _segmentedControl.layer.contents = (__bridge id)[UIImage imageNamed:@"pic_bt_bg"].CGImage;
        _segmentedControl.segmentedControlType = LMSegmentedControlAuto;
        _segmentedControl.selectedLineWidth = 26;
        _segmentedControl.selectedLineHeight = 4;
        _segmentedControl.selectedLineColor = HexColor(@"#FFC726");
        _segmentedControl.titleNormalColor = HexColor(@"#FFCCBE");
        _segmentedControl.titleSelectedColor = [UIColor whiteColor];
    }
    return _segmentedControl;
}
- (void)setUpUI{
    [self.view addSubview:self.segmentedControl];
    self.contentInsets = UIEdgeInsetsMake(40, 0, 0, 0);
}

- (void)autoLayout{
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
}

- (void)reloadView{
    NSArray *titles = [[self testCategory] map:^id(NSInteger index, id element) {
        return element[@"title"];
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.segmentedControl.titles = titles;
    });
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0;i < titles.count;i ++){
        CTVideoShopListViewController *vc = [[CTVideoShopListViewController alloc]init];
        [array addObject:vc];
    }
    self.viewControllers = array;
}

- (void)segmentedControl:(LMSegmentedControl *)segmentedControl didSelectedInbdex:(NSUInteger)index{
    [self scrollToIndex:index];
}
- (void)pageController:(CTPageController *)pageController didScrollToIndex:(NSInteger)index{
    [self.segmentedControl scrollToIndex:index];
}

- (NSArray *)testCategory{
    return @[@{@"title":@"今日精选"},@{@"title":@"女装"},@{@"title":@"母婴儿童"},@{@"title":@"内衣"},@{@"title":@"居家"},@{@"title":@"男装"},@{@"title":@"女装"},@{@"title":@"内裤"},@{@"title":@"电器"},@{@"title":@"酒水"},@{@"title":@"玩具"}];
}
@end
