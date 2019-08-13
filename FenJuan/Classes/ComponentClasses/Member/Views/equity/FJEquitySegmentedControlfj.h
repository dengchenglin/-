//
//  CTEquitySegmentedControl.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/27.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJEquitySegmentedControlfj;

@protocol CTEquitySegmentedControlDelegate <NSObject>
@property (nonatomic, strong) NSString *hhwhy;
@property (nonatomic, strong) NSString *nimazale;
@property (nonatomic, strong) NSString *commonpp;
@property (nonatomic, assign) NSInteger wodekahao;
@optional

- (void)segmentedControl:(FJEquitySegmentedControlfj *)segmentedControl didScrollWithIndex:(NSInteger)index;

@end

@interface FJEquitySegmentedControlfj : UIView

@property (nonatomic, copy) NSArray <NSString *> *titles;

@property (nonatomic, weak) id<CTEquitySegmentedControlDelegate> delegate;

- (void)scrollToIndex:(NSInteger)index;

@end
