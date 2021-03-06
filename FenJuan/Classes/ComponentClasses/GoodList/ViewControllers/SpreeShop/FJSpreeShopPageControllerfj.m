//
//  CTSpreeShopPageController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJSpreeShopPageControllerfj.h"

#import "LMSegmentedControl.h"

#import "FJSpreeShopListViewControllerfj.h"

#import "CTNetworkEngine+Recommend.h"

#import "FJTimeBuyCateModelfj.h"

@interface FJSpreeShopPageControllerfj ()<LMSegmentedControlDelegate>

@property (nonatomic, strong) LMSegmentedControl *segmentedControl;

@property (nonatomic, strong) NSArray <FJTimeBuyCateModelfj *> *cates;

@end

@implementation FJSpreeShopPageControllerfj

- (LMSegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        _segmentedControl = [[LMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 47)];
        _segmentedControl.delegate = self;
        _segmentedControl.layer.contents = (__bridge id)[UIImage imageNamed:@"p_bt_bg"].CGImage;
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
}

- (void)autoLayout{
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(47);
    }];
}

- (void)request{
    [CTRequest fj_allTimeBuyWithCallback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            [self reloadData:data];
            
        }
    }];
}

- (void)reloadData:(id)data{
    
    self.cates = [FJTimeBuyCateModelfj yy_modelsWithDatas:data];

    self.segmentedControl.titles = [self.cates map:^id(NSInteger index, FJTimeBuyCateModelfj *element) {
        return [NSString stringWithFormat:@"%@\n%@",element.time,element.text];;
    }];
    NSMutableArray *array = [NSMutableArray array];
    for(int i= 0;i < self.cates.count;i ++){
        FJSpreeShopListViewControllerfj *vc = [FJSpreeShopListViewControllerfj new];
        vc.model = self.cates[i];
        [array addObject:vc];
    }
    
    //当前时间戳
    NSString *nowTimeStamp = [DateUtil getNowDateTimestamp];
    __block NSInteger index = 0;
    [self.cates enumerateObjectsUsingBlock:^(FJTimeBuyCateModelfj * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj.start_time integerValue] >= [nowTimeStamp integerValue]){
            *stop = YES;
        }
        if(!(*stop)){
           index = idx;
        }
    }];
    self.toIndex = index;
    
    self.viewControllers = array;

}


- (void)segmentedControl:(LMSegmentedControl *)segmentedControl didSelectedInbdex:(NSUInteger)index{
    [self scrollToIndex:index];
}
- (void)pageController:(CTPageController *)pageController didScrollToIndex:(NSInteger)index{
    [self.segmentedControl scrollToIndex:index];
    
}
@end
