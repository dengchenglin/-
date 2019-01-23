//
//  CTLeftTextButton.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTLeftTextButton.h"

@implementation CTLeftTextButton

- (void)layoutSubviews{
     [super layoutSubviews];
     
     CGRect titleF = self.titleLabel.frame;
     
     CGRect imageF = self.imageView.frame;
     
     titleF.origin.x = imageF.origin.x;
     
     self.titleLabel.frame = titleF;
     
     imageF.origin.x = CGRectGetMaxX(titleF);
     
     self.imageView.frame = imageF;
    
}

@end
