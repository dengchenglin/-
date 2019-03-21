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
        if(self.completed){
            self.completed();
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
        }
    }];
}
//找回密码
- (void)resetPwd{
    [CTRequest resetPwdWithPhone:self.mobile pwd:self.viewModel.password smsCode:self.verCode callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            [MBProgressHUD showMBProgressHudWithTitle:@"设置成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}

@end
