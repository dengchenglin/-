//
//  CTShareViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTShareViewController.h"

#import "CTShareView.h"

#import "CTSharePopView.h"

#import "UIView+YYAdd.h"

#import "LMUpdateData.h"

#import "CTNetworkEngine+Member.h"

@interface CTShareViewController ()

@property (nonatomic, strong) CTShareView *shareView;

@end

@implementation CTShareViewController

- (CTShareView *)shareView{
    if(!_shareView){
        _shareView = NSMainBundleName(@"CTShareView_");
    }
    return _shareView;
}

- (void)setUpUI{
    self.title = @"邀请码";
    self.navigationBarStyle = CTNavigationBarWhite;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self setRightButtonWithTitle:@"分享海报" font:CTPsmFont(14) titleColor:CTColor selector:@selector(share)];
    [self.view addSubview:self.shareView];
}
- (void)request{
    NSString *qCodeUrl = [CTRequest qCodeUrl];
    [self.shareView.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:qCodeUrl]];
    self.shareView.inviteCodeLabel.text = [NSString stringWithFormat:@"邀请码 %@",[CTAppManager user].iv_code];
}

- (void)autoLayout{
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)share{
    UIImage *image = [self.shareView.preView snapshotImage];
    if(!image){
        [MBProgressHUD showMBProgressHudWithTitle:@"图片出错"];
        return;
    }
    [CTSharePopView showSharePopViewWithTypes:@[CTShareTypeWeChat,CTShareTypeQQ,CTShareTypeSaveImg] image:image imageUrl:nil title:nil url:nil];
    
   
   
}

@end
