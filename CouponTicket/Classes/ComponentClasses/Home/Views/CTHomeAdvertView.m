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
    _imageView.image = [UIImage imageNamed:@"pic_home_banner"];
    [self addSubview:_imageView];
}
- (void)autoLayout{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


@end
