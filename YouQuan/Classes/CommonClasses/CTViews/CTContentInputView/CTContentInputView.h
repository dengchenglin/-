//
//  CTContentInputView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/30.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTContentInputView : UIView

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxCountLabel;

@property (nonatomic, assign) NSUInteger maxCount;

@end
