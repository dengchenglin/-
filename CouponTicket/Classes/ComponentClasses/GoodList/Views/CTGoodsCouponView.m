//
//  CTGoodsCouponView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodsCouponView.h"
@interface CTGoodsCouponView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *couponTextCenterY;

@end
@implementation CTGoodsCouponView

- (void)setViewModel:(CTGoodsViewModel *)viewModel{
    _viewModel = viewModel;
    _couonTextLabel.text = _viewModel.model.coupon_amount;
    _couponTimeLabel.text = _viewModel.model.coupon_end_time;

    _couponTimeView.hidden = !_viewModel.model.coupon_end_time.length;
    _couponTextCenterY.constant = _couponTimeView.hidden?-4:-19;
    [self layoutIfNeeded];
}
@end
