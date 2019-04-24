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
#import "CTNetworkEngine+Member.h"

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
    self.title = @"分享收益";
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
    NSString *qCodeUrl = [CTRequest qCodeUrl];
    [self.shareView.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:qCodeUrl]];
    self.shareView.qrCodeLabel.text = [NSString stringWithFormat:@"邀请码 %@",[CTAppManager user].iv_code];
    self.shareView.usericon = [CTAppManager user].headimg;
    self.shareView.username = [CTAppManager user].nickname;
    self.shareView.userlevel = [CTAppManager user].level_txt;
    self.shareView.profit = _model.all_money;
    self.shareView.balance = _model.valuation_money;
}

- (void)share{
    __block UIImage *image;
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES]; dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        image = [self.view snapshotImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            if(!image){
                [MBProgressHUD showMBProgressHudWithTitle:@"图片出错"];
                return;
            }
              [CTSharePopView showSharePopViewWithTypes:@[CTShareTypeWeChat,CTShareTypeQQ,CTShareTypeSaveImg] image:image imageUrl:nil title:nil url:nil];
        });
    });
    
  
}
@end
