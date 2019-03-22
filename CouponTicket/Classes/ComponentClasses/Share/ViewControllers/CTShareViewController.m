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

#import "CTNetworkEngine+Mine.h"

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
}

- (void)autoLayout{
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)share{
    UIImage *image = [self.view snapshotImage];
    if(!image){
        [MBProgressHUD showMBProgressHudWithTitle:@"图片出错"];
        return;
    }
    [LMUpdateData updateImages:@[image] callback:^(NSArray<NSString *> *hashKeys) {
        NSString *imageUrl = LMImageUrlForKey([hashKeys safe_objectAtIndex:0]);
         [CTSharePopView showSharePopViewWithTypes:@[CTShareTypeWeChat,CTShareTypeQQ,CTShareTypeSaveImg] image:image imageUrl:imageUrl title:nil url:nil];
    }];
   
}

@end
