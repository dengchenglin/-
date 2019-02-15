//
//  CTSharePopView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTSharePopContainerView.h"

@interface CTSharePopView : UIView

+ (void)showSharePopViewWithTypes:(NSArray <NSString *>*)types image:(UIImage *)image title:(NSString *)title url:(NSString *)url;

@end
