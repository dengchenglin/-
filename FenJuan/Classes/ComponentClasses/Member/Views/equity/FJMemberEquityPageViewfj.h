//
//  CTMemberEquityPageView.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/27.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJMemberEquityPageViewfj;

@protocol CTMemberEquityPageViewDelegate <NSObject>

@optional

- (void)pageView:(FJMemberEquityPageViewfj *)pageView didScrollWithIndex:(NSInteger)index;

@end

@interface FJMemberEquityPageViewfj : UIView

@property (nonatomic, weak) id<CTMemberEquityPageViewDelegate> delegate;

@property (nonatomic, copy) NSArray *list;

- (void)scrollToIndex:(NSInteger)index;

@property (nonatomic, strong) NSString *hhwhy;
@property (nonatomic, strong) NSString *nimazale;
@property (nonatomic, strong) NSString *commonpp;
@property (nonatomic, assign) NSInteger wodekahao;
@end
