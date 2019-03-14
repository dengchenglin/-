//
//  CTHomeAdvertView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHomeAdvertView.h"

@implementation CTHomeAdvertView

ViewInstance(setUp)

- (void)setUp{
    [self setUpUI];
    [self autoLayout];

}
- (void)setUpUI{
    _imageView = [[UIImageView alloc]init];

    [self addSubview:_imageView];
}
- (void)autoLayout{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setModel:(CTActivityModel *)model{
    _model = model;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.img]];
}

@end
