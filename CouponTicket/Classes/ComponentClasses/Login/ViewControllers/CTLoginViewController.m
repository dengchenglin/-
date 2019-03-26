//
//  CTLoginViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTLoginViewController.h"

#import "CTLoginViewModel.h"

#import "CTLoginView.h"

#import "CTRegisterViewController.h"

#import "CTForgetViewController.h"

#import "CTAgreementViewController.h"

#import "CTThirdRegController.h"

#import "CTNetworkEngine+H5Url.h"

@interface CTLoginViewController ()

@property (nonatomic, strong) CTLoginView *loginView;

@property (nonatomic, copy) void (^callback)(BOOL logined);

@property (nonatomic, strong) CTLoginViewModel *viewModel;

@end

@implementation CTLoginViewController

+ (void)showLoginFormViewController:(UIViewController *)viewController callback:(void(^)(BOOL logined))callback{
    CTLoginViewController *vc = [[CTLoginViewController alloc]init];
    vc.callback = callback;
    CTNavigationController *nav = [[CTNavigationController alloc]initWithRootViewController:vc];
    [viewController presentViewController:nav animated:YES completion:nil];
}

- (CTLoginView *)loginView{
    if(!_loginView){
        _loginView = NSMainBundleName(@"CTLoginView_");
    }
    return _loginView;
}

- (CTLoginViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [CTLoginViewModel new];
    }
    return _viewModel;
}

- (void)setUpUI{
    [self setLeftDefaultItem];
    self.title = @"登录";
    [self.view addSubview:self.loginView];
}

- (void)autoLayout{
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)bindViewModel{
    RAC(self.viewModel,account) = self.loginView.accountTfd.rac_textSignal;
    RAC(self.viewModel,password) = self.loginView.passwordTfd.rac_textSignal;
    RAC(self.loginView.loginButton,enabled) = self.viewModel.validLoginSignal;
}

- (void)setUpEvent
{
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:CTDidLoginNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        [self successBack];
    }];
    //登录
    [self.loginView.loginButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(![self.viewModel.account validateMobile]){
            [MBProgressHUD showMBProgressHudWithTitle:@"手机格式不正确"];
            return ;
        }
        [CTRequest loginWithType:CTLoginPhone openid:nil phone:self.viewModel.account pwd:self.viewModel.password callback:^(id data, CLRequest *request, CTNetError error) {
            if(!error){
               [CTAppManager saveUserWithInfo:data];
                [CTAppManager saveToken:data[@"token"]];
                POST_NOTIFICATION(CTDidLoginNotification);
            }
            
        }];
    }];
    //注册
    [self.loginView.registerButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        CTRegisterViewController *vc = [CTRegisterViewController new];
        vc.eventKind = CTEventKindRegister;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //忘记密码
    [self.loginView.forgetButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        CTForgetViewController *vc = [CTForgetViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //qq登录
    [self.loginView.qqButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [UMShareManager getUserInfoForPlatform:UMSocialPlatformType_QQ completion:^(CTUMSocialUserInfoResponse *response) {
            @strongify(self)
            [self thirdLoginWithType:CTLoginQQ response:response];
        }];
    }];
    //微信登录
    [self.loginView.wechatButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [UMShareManager getUserInfoForPlatform:UMSocialPlatformType_WechatSession completion:^(CTUMSocialUserInfoResponse *response) {
            @strongify(self)
            [self thirdLoginWithType:CTLoginWeChat response:response];
        }];
    }];
    //同意协议
    [self.loginView.agreementButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
       UIViewController *vc = [[CTModuleManager webService]pushWebFromViewController:self url:CTH5UrlForType(CTH5UrlRegAgreement)];
        vc.title = @"注册协议";
//        CTAgreementViewController *vc = [CTAgreementViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

//第三方登录
- (void)thirdLoginWithType:(CTLoginType)loginType  response:(CTUMSocialUserInfoResponse *)response{
    [CTRequest loginWithType:loginType openid:response.openid phone:nil pwd:nil callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            [CTAppManager saveUserWithInfo:data];
            [CTAppManager saveToken:data[@"token"]];
            POST_NOTIFICATION(CTDidLoginNotification);
        }
        else{
            NSInteger status = [data[@"status"] integerValue];
            if(status == 402){
                CTThirdRegController *vc = [CTThirdRegController new];
                vc.eventKind = GetEventKindWithLoginType(loginType);
                vc.response = response;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }];
}

- (void)successBack{
    if(self.callback){
        self.callback(YES);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)back{
    if(self.callback){
        self.callback(NO);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
