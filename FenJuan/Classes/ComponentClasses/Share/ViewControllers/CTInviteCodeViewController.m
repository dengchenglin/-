//
//  CTInviteCodeViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/5.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTInviteCodeViewController.h"
#import "CTInviteCodeView.h"
#import "CTInviteCodeButton.h"
#import "CTIvCodeContainerView.h"
#import "CTNetworkEngine+Member.h"
#import "CTIvCodeImgView.h"
#import "CTSharePopupView.h"

#define CTInviteCodeViewHeight ((SCREEN_WIDTH - 46)*0.33 + 52 + NAVBAR_HEIGHT)
#define CTInviteCodeButtonHeight 102

@interface CTInviteCodeModel:NSObject
@property (nonatomic, copy) NSString *iv_code;
@property (nonatomic, copy) NSString *iv_code_img;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSArray <NSString *> *imgs;
@end
@implementation CTInviteCodeModel


@end
@interface CTInviteCodeViewController ()
@property (nonatomic, strong) CTInviteCodeView *ivCodeView;
@property (nonatomic, strong) CTInviteCodeButton *doneButton;
@property (nonatomic, strong) CTIvCodeContainerView *imgContainerView;
@property (nonatomic, strong) CTInviteCodeModel *model;
@end

@implementation CTInviteCodeViewController
- (CTInviteCodeView *)ivCodeView{
    if(!_ivCodeView){
        _ivCodeView = NSMainBundleName(@"CTInviteCodeView_");
    }
    return _ivCodeView;
}
- (CTInviteCodeButton *)doneButton{
    if(!_doneButton){
        _doneButton = NSMainBundleClass(CTInviteCodeButton.class);
    }
    return _doneButton;
}
- (CTIvCodeContainerView *)imgContainerView{
    if(!_imgContainerView){
        _imgContainerView = [[CTIvCodeContainerView alloc]initWithFrame:CGRectMake(0, CTInviteCodeViewHeight , SCREEN_WIDTH, SCREEN_HEIGHT - CTInviteCodeViewHeight - CTInviteCodeButtonHeight)];
        
    }
    return _imgContainerView;
}
- (void)setUpUI{
    self.title = @"邀请好友";
    [self.view addSubview:self.ivCodeView];
    [self.view addSubview:self.imgContainerView];
    [self.view addSubview:self.doneButton];
}
- (void)autoLayout{
    [self.ivCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(0);
        make.height.mas_equalTo(CTInviteCodeViewHeight);
    }];
    [self.doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(CTInviteCodeButtonHeight);
    }];
}

- (void)request{
    [CTRequest fj_shareInfoWithCallback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            self.model = [CTInviteCodeModel yy_modelWithDictionary:data];
            self.ivCodeView.ivCode = _model.iv_code;
            [CTIvCodeImgView createImagesWithBackgroundImgs:_model.imgs ivCodeImg:_model.iv_code_img ivCode:_model.iv_code completed:^(NSArray<UIImage *> * images) {
                self.imgContainerView.images = images;
            }];
        }
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.doneButton.cpyButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(self.model.share_url.length){
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            
            pasteboard.string =  self.model.share_url;
            [pasteboard updateCount];
            [MBProgressHUD showMBProgressHudWithTitle:@"复制链接成功"];
        }
        else{
            [MBProgressHUD showMBProgressHudWithTitle:@"复制链接失败"];
        }
    }];
    [self.doneButton.shareButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(self.imgContainerView.currentImage){
            [CTSharePopupView showSharePopupWithImages:@[self.imgContainerView.currentImage] onView:self.view contentInset:UIEdgeInsetsMake(NAVBAR_HEIGHT, 0, 0, 0 )];
        }
        else{
            [MBProgressHUD showMBProgressHudWithTitle:@"图片出错,请刷新重新操作~"];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
}

@end
