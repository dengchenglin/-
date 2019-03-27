//
//  CTEquitySegmentedControl.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/27.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTEquitySegmentedControl;

@protocol CTEquitySegmentedControlDelegate <NSObject>

@optional

- (void)segmentedControl:(CTEquitySegmentedControl *)segmentedControl didScrollWithIndex:(NSInteger)index;

@end

@interface CTEquitySegmentedControl : UIView

@property (nonatomic, copy) NSArray <NSString *> *titles;

@property (nonatomic, weak) id<CTEquitySegmentedControlDelegate> delegate;

- (void)scrollToIndex:(NSInteger)index;

@end
