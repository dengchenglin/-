//
//  CTSetPasswordViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSetPasswordViewController.h"

#import "CTSetPasswordView.h"

#import "CTSetPasswordViewModel.h"

#import "CTNetworkEngine+Member.h"

@interface CTSetPasswordViewController ()

@property (nonatomic, strong) CTSetPasswordView *passwordView;

@property (nonatomic, strong) CTSetPasswordViewModel *viewModel;

@end

@implementation CTSetPasswordViewController

- (CTSetPasswordView *)passwordView{
    if(!_passwordView){
        _passwordView = NSMainBundleName(@"CTSetPasswordView_");
    }
    return _passwordView;
}

- (CTSetPasswordViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [CTSetPasswordViewModel new];
    }
    return _viewModel;
}

- (void)setUpUI{
    self.title = GetEventTitleStr(_eventKind);
    [self.view addSubview:self.passwordView];
    
    if(_eventKind == CTEventKindWithDraw){
        self.passwordView.doneButton.layer.cornerRadius = 23;
        self.passwordView.passwordTfd.maxCount = 6;
        self.passwordView.passwordTfd.keyboardType = UIKeyboardTypeNumberPad;
        self.passwordView.repasswordTfd.maxCount = 6;
        self.passwordView.repasswordTfd.keyboardType = UIKeyboardTypeNumberPad;
        self.passwordView.passwordTfd.placeholder = @"请输入六位数纯数字密码";
    }
}

- (void)autoLayout{
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.passwordView.doneButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [self.view endEditing:YES];
        if(!self.viewModel.password.length){
            [MBProgressHUD showMBProgressHudWithTitle:@"请输入密码"];
            return ;
        }
        if(!self.viewModel.repassword.length){
            [MBProgressHUD showMBProgressHudWithTitle:@"请再次输入密码"];
            return ;
        }
        if(!self.viewModel.psdConsistented){
            [MBProgressHUD showMBProgressHudWithTitle:@"密码不一致"];
            return ;
        }
        switch (self.eventKind) {
            case CTEventKindRegister:
                {
                    [self registerWithType:CTLoginPhone];
                }
                break;
            case CTEventKindQQRegister:
            {
                [self registerWithType:CTLoginQQ];
            }
                break;
            case CTEventKindWechatRegister:
            {
                [self registerWithType:CTLoginWeChat];
            }
                break;
            case CTEventKindForgetpsd:{
                [self resetPwd];
            }
                 break;
            case CTEventKindWithDraw:{
                [self resetWithDrawPwd];
            }
                break;
            default:
                break;
        }
    }];
}

- (void)bindViewModel{
    RAC(self.viewModel,password) = self.passwordView.passwordTfd.rac_textSignal;
    RAC(self.viewModel,repassword) = self.passwordView.repasswordTfd.rac_textSignal;
    RAC(self.passwordView.doneButton,enabled) = self.viewModel.validRegisterSignal;
}


//手机注册
- (void)registerWithType:(CTLoginType)type{
    [CTRequest registerWithPhone:self.mobile pwd:self.viewModel.password type:type ivCode:self.inviteCode smsCode:self.verCode openid:self.response.openid nickname:self.response.name headicon:self.response.iconurl unionid:self.response.unionId callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            [CTAppManager saveUserWithInfo:data];
            [CTAppManager saveToken:data[@"token"]];
            POST_NOTIFICATION(CTDidLoginNotification);
            if(self.completed){
                self.completed();
            }
        }
    }];
}
//找回密码
- (void)resetPwd{
    [CTRequest resetPwdWithPhone:self.mobile pwd:self.viewModel.password smsCode:self.verCode callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            [MBProgressHUD showMBProgressHudWithTitle:@"设置成功"];
            if(self.completed){
                self.completed();
            }
            else{
             
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
    }];
}

//设置提现密码
- (void)resetWithDrawPwd{
    [CTRequest setPaypwdWithPhone:self.mobile pwd:self.viewModel.password smsCode:self.verCode callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            [MBProgressHUD showMBProgressHudWithTitle:@"设置成功"];
            [CTAppManager user].ishas_pay_pwd = YES;
            if(self.completed){
                self.completed();
            }
            else{
              
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
    }];
}

@end
