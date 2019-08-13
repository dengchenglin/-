//
//  CTEarnRankCell.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/13.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJEarnRankCellfj.h"

@implementation FJEarnRankCellfj

- (void)setViewModel:(FJEarnRankIndexViewModelfj *)viewModel{
    _viewModel = viewModel;
    
    [_userIconImageView sd_setImageWithURL:[NSURL URLWithString:_viewModel.headimg]];
    _mobileLabel.text = _viewModel.phone;
    _earnLabel.text = _viewModel.money;
    if(_viewModel.showRankImage){
        _rankLogo.hidden = NO;
        _rankLabel.hidden = YES;
        _rankLogo.image = _viewModel.rankImage;
    }
    else{
        _rankLogo.hidden = YES;
        _rankLabel.hidden = NO;
        _rankLabel.text = _viewModel.rank;
    }
    
}

@end
