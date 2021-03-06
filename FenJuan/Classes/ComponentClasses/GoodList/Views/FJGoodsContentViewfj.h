//
//  CTGoodsContentView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/2.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJGoodsContentViewfj : UIView
@property (weak, nonatomic) IBOutlet UIWebView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeight;
@property (nonatomic, copy) NSString *htmlString;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) void (^heightChangeBlock)(CGFloat height);
@end
