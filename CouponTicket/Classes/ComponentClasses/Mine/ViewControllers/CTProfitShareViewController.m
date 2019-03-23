//
//  CTProfitShareViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTProfitShareViewController.h"

#import "CTProfitShareView.h"

#import "CTSharePopView.h"

#import "UIView+YYAdd.h"

@interface CTProfitShareViewController ()

@property (nonatomic, strong) CTProfitShareView *shareView;

@end

@implementation CTProfitShareViewController

- (CTProfitShareView *)shareView{
    if(!_shareView){
        _shareView = NSMainBundleName(@"CTProfitShareView_");
    }
    return _shareView;
}

- (void)setUpUI{
    self.title = @"邀请码";
    self.navigationBarStyle = CTNavigationBarWhite;
    [self setRightButtonWithTitle:@"分享海报" font:CTPsmFont(14) titleColor:CTColor selector:@selector(share)];
    [self.view addSubview:self.shareView];
}

- (void)autoLayout{
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)reloadView{
    self.shareView.profit = @"105.1";
    self.shareView.balance = @"15.09";
}

- (void)share{
    __block UIImage *image;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES]; dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        image = [self.view snapshotImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(!image){
                [MBProgressHUD showMBProgressHudWithTitle:@"图片出错"];
                return;
            }
              [CTSharePopView showSharePopViewWithTypes:@[CTShareTypeWeChat,CTShareTypeQQ,CTShareTypeSaveImg] image:image imageUrl:nil title:nil url:nil];
        });
    });
    
  
}
@end
