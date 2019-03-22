//
//  CTShareView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTShareView.h"

@interface CTShareView()



@end

@implementation CTShareView

- (void)awakeFromNib{
    [super awakeFromNib];
    @weakify(self)
    [_downLoadButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        UIImage *image = [self.preView toImage];
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        [image saveToPhotosWithCompleted:^(BOOL success) {
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            [MBProgressHUD showMBProgressHudWithTitle:success?@"保存成功":@"保存失败"];
        }];
    }];
}

@end
