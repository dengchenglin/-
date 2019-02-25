//
//  CTVideoGoodListCell.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTVideoGoodListCell.h"

@implementation CTVideoGoodListCell

- (void)awakeFromNib {
    [super awakeFromNib];
     _goodView = NSMainBundleClass(CTGoodListView_.class);
    [self.goodBackView addSubview:_goodView];
    [_goodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


@end
