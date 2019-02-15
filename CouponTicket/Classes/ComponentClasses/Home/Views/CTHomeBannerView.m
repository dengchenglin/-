//
//  CTHomeBannerView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeBannerView.h"

#import "SDCycleScrollView.h"

#import "UIView+YYAdd.h"

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
        
        _cycleScrollView.pageControlDotSize = CGSizeMake(7, 7);
        
        UIView *currentPageDotView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        currentPageDotView.opaque = 0;
        currentPageDotView.layer.cornerRadius = 5;
        currentPageDotView.backgroundColor = RGBColor(255, 97, 36);
        UIImage *currentPageDotImage = [currentPageDotView snapshotImage];

        UIView *pageDotView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        pageDotView.opaque = 0;
        pageDotView.layer.cornerRadius = 5;
        pageDotView.backgroundColor = RGBAColor(20, 20, 20, 0.2);
        UIImage *pageDotImage = [pageDotView snapshotImage];
        
        _cycleScrollView.currentPageDotImage = currentPageDotImage;
        _cycleScrollView.pageDotImage = pageDotImage;
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
