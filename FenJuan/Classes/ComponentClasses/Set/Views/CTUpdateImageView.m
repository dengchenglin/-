//
//  CTUpdateImageView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/30.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTUpdateImageView.h"

@implementation CTUpdateImageView

- (void)awakeFromNib{
    [super awakeFromNib];
    @weakify(self)
    [self.photosView setImageCountDidChangedBlock:^(NSInteger count) {
            @strongify(self)
        self.countDescLabel.text = [NSString stringWithFormat:@"(%zu/%lu)",count,(unsigned long)self.photosView.maxCount];
    }];
}

@end
