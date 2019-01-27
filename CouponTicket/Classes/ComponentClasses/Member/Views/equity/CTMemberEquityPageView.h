//
//  CTMemberEquityPageView.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/27.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTMemberEquityPageView;

@protocol CTMemberEquityPageViewDelegate <NSObject>

@optional

- (void)pageView:(CTMemberEquityPageView *)pageView didScrollWithIndex:(NSInteger)index;

@end

@interface CTMemberEquityPageView : UIView

@property (nonatomic, assign) CTMemberLevel level;

@property (nonatomic, weak) id<CTMemberEquityPageViewDelegate> delegate;

- (void)scrollToIndex:(NSInteger)index;


@end
