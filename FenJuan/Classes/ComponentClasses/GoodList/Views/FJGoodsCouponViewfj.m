//
//  CTGoodsCouponView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJGoodsCouponViewfj.h"
@interface FJGoodsCouponViewfj()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *couponTextCenterY;

@end
@implementation FJGoodsCouponViewfj

- (void)setViewModel:(CTGoodsViewModel *)viewModel{
    _viewModel = viewModel;
    _couonTextLabel.text = _viewModel.model.coupon_text;
    _couponTimeLabel.text = _viewModel.model.coupon_end_time;

    _couponTimeView.hidden = !_viewModel.model.coupon_end_time.length;
    _couponTextCenterY.constant = _couponTimeView.hidden?-4:-19;
    [self layoutIfNeeded];
}
@end
