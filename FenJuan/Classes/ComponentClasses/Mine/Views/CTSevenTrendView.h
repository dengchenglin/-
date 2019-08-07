//
//  CTSevenTrendView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTSevenTrendView : UIView
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIWebView *trendView;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) void (^heightDidChangeBlock)(CGFloat height);

@end
