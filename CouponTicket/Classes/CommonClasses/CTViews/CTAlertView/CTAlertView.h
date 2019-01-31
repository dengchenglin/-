//
//  CTAlertView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTAlertView : UIView

@property (nonatomic, copy) void(^closeBlock)(void);

@property (nonatomic, copy) void(^callback)(NSUInteger buttonIndex);


@end
