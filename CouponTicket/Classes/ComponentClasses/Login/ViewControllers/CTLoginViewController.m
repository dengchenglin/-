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
    //登录
    [self.loginView.loginButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(![self.viewModel.account validateMobile]){
            [MBProgressHUD showMBProgressHudWithTitle:@"手机格式不正确"];
            return ;
        }
        [CTAppManager sharedInstance].user = [CTUser new];
        if(self.callback){
            self.callback(YES);
        }
        [self back];
    }];
    //注册
    [self.loginView.registerButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        CTRegisterViewController *vc = [CTRegisterViewController new];
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
    
    }];
    //微信登录
    [self.loginView.wechatButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        
    }];
    //同意协议
    [self.loginView.agreementButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        CTAgreementViewController *vc = [CTAgreementViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

@end
