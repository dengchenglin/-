//
//  CTInviteCodeView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/5.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTInviteCodeView : UIView
@property (weak, nonatomic) IBOutlet UILabel *ivcodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *cpyButton;
@property (nonatomic, copy) NSString *ivCode;
@end

NS_ASSUME_NONNULL_END
