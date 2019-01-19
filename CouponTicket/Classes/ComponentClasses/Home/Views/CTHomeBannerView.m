//
//  CTHomeBannerView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeBannerView.h"

#import "SDCycleScrollView.h"

@interface CTHomeBannerView()<SDCycleScrollViewDelegate>

@end

@implementation CTHomeBannerView{
    SDCycleScrollView *_cycleScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds shouldInfiniteLoop:YES imageNamesGroup:nil];
        _cycleScrollView.backgroundColor = RGBColor(240, 240, 240);
        _cycleScrollView.delegate = self;
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
         _cycleScrollView.autoScrollTimeInterval = 5.0;
        [self addSubview:_cycleScrollView];
       
    }
    return self;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if(self.clickItemBlock){
        self.clickItemBlock(index);
    }
}

- (void)setBanner_imgs:(NSArray<NSString *> *)banner_imgs{
    _banner_imgs = banner_imgs;
    _cycleScrollView.imageURLStringsGroup = _banner_imgs;
}

@end
