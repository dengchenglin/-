//
//  CTGoodsContentView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/2.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTGoodsContentView : UIView

@property (weak, nonatomic) IBOutlet UIWebView *contentView;

@property (nonatomic, copy) NSString *htmlString;

@end
