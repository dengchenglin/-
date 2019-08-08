//
//  CTGoodsBuyView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJGoodsBuyViewfj.h"

@implementation FJGoodsBuyViewfj
- (void)awakeFromNib{
    [super awakeFromNib];
    _awardView.layer.contents = (__bridge id)[UIImage imageNamed:@"p_bt_bg"].CGImage;
}
- (void)setViewModel:(CTGoodsViewModel *)viewModel{
    _viewModel = viewModel;
    _collectButton.selected = _viewModel.model.is_favorite;
    _awardLabel.text = _viewModel.model.commission_money;
    _awardView.hidden = !_viewModel.model.commission_money.floatValue;
}
@end
