//
//  UIImageView+CTHelper.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "UIImageView+CTHelper.h"

@implementation UIImageView (CTHelper)

- (void)ct_setImageWithImg:(id)img{
    if([img isKindOfClass:[NSString class]]){
        if([img hasPrefix:@"http"]){
            [self sd_setImageWithURL:[NSURL URLWithString:img]];
        }
        else{
            [self sd_setImageWithURL:[NSURL URLWithString:img]];
        }
    }
    else if([img isKindOfClass:[UIImage class]]){
        self.image = img;
    }
}

@end
