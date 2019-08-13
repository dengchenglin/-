//
//  CTGetCodeViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJGetCodeViewControllerfj.h"

#import "FJSetPasswordViewControllerfj.h"

#import "CTGetCodeView.h"

#import "FJGetCodeViewModelfj.h"
#import "CTNetworkEngine+Cash.h"

@interface FJGetCodeViewControllerfj ()

@property (nonatomic, strong) CTGetCodeView *getCodeView;

@property (nonatomic, strong) FJGetCodeViewModelfj *viewModel;

@end

@implementation FJGetCodeViewControllerfj

- (CTGetCodeView *)getCodeView{
    if(!_getCodeView){
        _getCodeView = NSMainBundleName(@"CTGetCodeView_");
    }
    return _getCodeView;
}

- (FJGetCodeViewModelfj *)viewModel{
    if(!_viewModel){
        _viewModel = [FJGetCodeViewModelfj new];
    }
    return _viewModel;
}

- (void)setUpUI{
    self.title = GetEventTitleStr(_eventKind);
    [self.view addSubview:self.getCodeView];

}

- (void)reloadView{
    self.getCodeView.phoneTfd.text = self.mobile;
    if(_eventKind == CTEventKindWithDraw){
        self.getCodeView.nextButton.layer.cornerRadius = 23;
    }
    if(_eventKind == CTEventKindBindAlipay){
        self.getCodeView.phoneTfd.userInteractionEnabled = NO;
        self.getCodeView.phoneTfd.text = [CTAppManager user].phone;
        [self.getCodeView.nextButton setTitle:@"绑定" forState:UIControlStateNormal];
    }
    if(_eventKind == CTEventKindQQBind || _eventKind == CTEventKindWechatBind){
        [self.getCodeView.nextButton setTitle:@"绑定" forState:UIControlStateNormal];
    }
}

- (void)autoLayout{
    [self.getCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setUpEvent{
    @weakify(self)
    //获取验证码
    [self.getCodeView.getCodeButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(!self.viewModel.mobile.length){
            [MBProgressHUD showMBProgressHudWithTitle:@"请输入手机号"];
            return ;
        }
        [CTRequest fj_smsSendWithPhone:self.viewModel.mobile type:GetSendCodeStrForEventKind(self.eventKind) callback:^(id data, CLRequest *request, CTNetError error) {
            @strongify(self)
            if(!error){
                [MBProgressHUD showMBProgressHudWithTitle:@"发送成功"];
                [self.getCodeView.getCodeButton startTimer];
            }
        }];
    }];
    [self.getCodeView.nextButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        //第三方绑定已有账户
        CTLoginType type = ((self.eventKind == CTEventKindQQBind)?CTLoginQQ:CTLoginWeChat);
        if(self.eventKind == CTEventKindQQBind || self.eventKind == CTEventKindWechatBind){
            [CTRequest fj_bindPhoneWithPhone:self.viewModel.mobile type:type ivCode:self.inviteCode smsCode:self.viewModel.code openid:self.response.openid nickname:self.response.name headicon:self.response.iconurl unionid:self.response.unionId callback:^(id data, CLRequest *request, CTNetError error) {
                if(!error){
                    [CTAppManager saveUserWithInfo:data];
                    [CTAppManager saveToken:data[@"token"]];
                    POST_NOTIFICATION(CTDidLoginNotification);
                }
            }];
        }//支付宝账号绑定
        else if (self.eventKind == CTEventKindBindAlipay){
            [self bindApliay];
        }
        else{
            [CTRequest fj_checkSmsCodeWithPhone:self.viewModel.mobile smsCode:self.viewModel.code callback:^(id data, CLRequest *request, CTNetError error) {
                @strongify(self)
                if(error){
                    [MBProgressHUD showMBProgressHudWithTitle:@"验证码错误!"];
                }
                else{
                    FJSetPasswordViewControllerfj *vc = [FJSetPasswordViewControllerfj new];
                    vc.eventKind = self.eventKind;
                    vc.mobile = self.viewModel.mobile;
                    vc.inviteCode = self.inviteCode;
                    vc.verCode = self.viewModel.code;
                    vc.response = self.response;
                    vc.completed = self.completed;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }];
        }
    }];
    
}

- (void)bindApliay{
    [CTRequest fj_accountSaveWithAccount:self.cashAccount username:self.cashName phone:nil smsCode:self.viewModel.code callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            [CTAppManager user].ishas_cash_account = YES;
            if(self.completed){
                self.completed();
            }
        }
    }];
}

- (void)bindViewModel{
    RAC(self.viewModel,code) = self.getCodeView.codeTfd.cl_textSignal;
    RAC(self.viewModel,mobile) = self.getCodeView.phoneTfd.cl_textSignal;
    RAC(self.getCodeView.nextButton,enabled) = self.viewModel.validNextSignal;
}


@end
