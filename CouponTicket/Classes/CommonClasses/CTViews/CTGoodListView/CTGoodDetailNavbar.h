//
//  CTGoodDetailNavbar.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTGoodDetailNavbar : UIView
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (assign, nonatomic) CGFloat backgroundAlpha;

@end

NS_ASSUME_NONNULL_END
