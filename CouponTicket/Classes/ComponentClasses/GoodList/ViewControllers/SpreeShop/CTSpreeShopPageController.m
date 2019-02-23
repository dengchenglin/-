//
//  CTSpreeShopPageController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSpreeShopPageController.h"

#import "LMSegmentedControl.h"

#import "CTSpreeShopListViewController.h"

@interface CTSpreeShopPageController ()<LMSegmentedControlDelegate>

@property (nonatomic, strong) LMSegmentedControl *segmentedControl;

@end

@implementation CTSpreeShopPageController

- (LMSegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        _segmentedControl = [[LMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 47)];
        _segmentedControl.delegate = self;
        _segmentedControl.layer.contents = (__bridge id)[UIImage imageNamed:@"pic_bt_bg"].CGImage;
        _segmentedControl.titleNormalColor = [UIColor whiteColor];
        _segmentedControl.titleSelectedColor = [UIColor whiteColor];
        _segmentedControl.selectedLineColor = RGBColor(255, 199, 38);
        _segmentedControl.itemSize = CGSizeMake(68, 47);
        _segmentedControl.segmentedControlType = LMSegmentedControlConstant;
    }
    return _segmentedControl;
}

- (void)setUpUI{
    self.title = @"整点抢购";
    [self.view addSubview:self.segmentedControl];
    self.contentInsets = UIEdgeInsetsMake(47, 0, 0, 0);
    __block UIScrollView *scrollView = nil;
    [self.pageController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) scrollView = (UIScrollView *)obj;
        
    }];
   

}

- (void)autoLayout{
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(47);
    }];
}

- (void)reloadView{
    NSMutableArray *titles = [NSMutableArray array];
    for(int i = 0;i < 12;i ++){
        NSString *title = [NSString stringWithFormat:@"08:00\n已结束"];
        [titles addObject:title];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.segmentedControl.titles = titles;
    });
    NSMutableArray *array = [NSMutableArray array];
    for(int i= 0;i < titles.count;i ++){
        CTSpreeShopListViewController *vc = [CTSpreeShopListViewController new];
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
@end
