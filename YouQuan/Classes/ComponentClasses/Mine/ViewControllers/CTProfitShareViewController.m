//
//  CTProfitShareViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTProfitShareViewController.h"
#import "CTShareProfitView.h"
#import "CTShareProfitContainerView.h"
#import "UIView+YYAdd.h"
#import "CTNetworkEngine+Member.h"

#import "CTSharePopupView.h"

@interface CTProfitShareViewController ()

@property (nonatomic, strong) CTShareProfitContainerView *imgContainerView;

@property (nonatomic, strong) UIButton *shareButton;

@end

@implementation CTProfitShareViewController

- (CTShareProfitContainerView *)imgContainerView{
    if(!_imgContainerView){
        _imgContainerView = [[CTShareProfitContainerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - 100)];
    }
    return _imgContainerView;
}
- (UIButton *)shareButton{
    if(!_shareButton){
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setTitle:@"立即分享" forState:UIControlStateNormal];
        [_shareButton setBackgroundImage:[UIImage imageNamed:@"pic_rectangle2"] forState:UIControlStateNormal];
        [_shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _shareButton.clipsToBounds = YES;
        _shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _shareButton;
}

- (void)setUpUI{
    self.title = @"分享收益";
    self.navigationBarStyle = CTNavigationBarWhite;
    [self setRightButtonWithTitle:@"分享海报" font:CTPsmFont(14) titleColor:CTColor selector:@selector(share)];
    [self.view addSubview:self.imgContainerView];
    [self.view addSubview:self.shareButton];
    
}

- (void)autoLayout{
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(210, 48));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo((48 - 100)/2);
    }];
}

- (void)request{
    [CTRequest shareInfoWithCallback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            [CTShareProfitView createImagesWithBackgroundImgs:data[@"imgs"] ivCodeImg:data[@"iv_code_img"] ivCode:data[@"iv_code"] user:[CTAppManager user] completed:^(NSArray<UIImage *> * images) {
              
                self.imgContainerView.images = images;
            }];
        }
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.shareButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(self.imgContainerView.currentImage){
            [CTSharePopupView showSharePopupWithImages:@[self.imgContainerView.currentImage] onView:self.view contentInset:UIEdgeInsetsMake(NAVBAR_HEIGHT, 0, 0, 0 )];
        }
        else{
            [MBProgressHUD showMBProgressHudWithTitle:@"图片出错,请刷新重新操作~"];
        }
    }];
}

@end
