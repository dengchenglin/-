//
//  CTSharePopContainerView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const CTShareTypeWeChat = @"CTShareTypeWeChat";
static NSString * const CTShareTypeQQ = @"CTShareTypeQQ";
static NSString * const CTShareTypeSaveImg = @"CTShareTypeSaveImg";

@interface CTSharePopContainerView : UIView
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (nonatomic, copy) NSArray <NSString *>*shareTypes;
@property (nonatomic, copy) void(^clickItemBlock)(NSInteger index);
+ (CGFloat)heightForItemCount:(NSInteger)index;
@end
