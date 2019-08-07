//
//  CTWithDrawInputView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CTWithdrawTextField: UITextField


@end

@interface CTWithDrawInputView : UIView
@property (weak, nonatomic) IBOutlet CTWithdrawTextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UILabel *balanceNoticeLabel;
@property (nonatomic, copy) void (^withDrawAllBlock)(void);
@end
