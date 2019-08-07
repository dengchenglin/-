//
//  CTEquitySegmentedControl.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/27.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTEquitySegmentedControl.h"

#import "LMSegmentedControl.h"

@interface CTEquitySegmentedControl ()<LMSegmentedControlDelegate>

@property (nonatomic, strong) LMSegmentedControl *segmentedControl;

@end

@implementation CTEquitySegmentedControl
{
    NSArray *_titles;
}
ViewInstance(setUp)

- (void)setUp{
    _segmentedControl = [[LMSegmentedControl alloc]init];
    _segmentedControl.titleNormalColor = RGBColor(153, 153, 153);
    _segmentedControl.titleSelectedColor = RGBColor(20, 20, 20);
    _segmentedControl.selectedLineColor = RGBColor(20, 20, 20);
    _segmentedControl.selectedLineWidth = 24;
    _segmentedControl.selectedLineHeight = 4;
    _segmentedControl.delegate = self;
    _segmentedControl.segmentedControlType = LMSegmentedControlScreen;
    [self addSubview:_segmentedControl];
    
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


- (void)setTitles:(NSArray<NSString *> *)titles{
    _titles = titles;
    _segmentedControl.titles = titles;
}

- (void)scrollToIndex:(NSInteger)index{
    [_segmentedControl scrollToIndex:index];
}

- (void)segmentedControl:(LMSegmentedControl *)segmentedControl didSelectedInbdex:(NSUInteger)index{
    if(_delegate && [_delegate respondsToSelector:@selector(segmentedControl:didScrollWithIndex:)]){
        [_delegate segmentedControl:self didScrollWithIndex:index];
    }
}

@end
