//
//  CTPasteCheckPopView.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/24.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTPasteCheckPopView : UIView

+ (void)showPopViewWithText:(NSString *)text callback:(void(^)(NSInteger buttonIndex))callback;

@end
