//
//  CTForgetViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJForgetViewControllerfj.h"

#import "FJForgetpsdViewModelfj.h"

#import "FJForgetPsdViewfj.h"

#import "FJGetCodeViewControllerfj.h"

@interface FJForgetViewControllerfj ()

@property (nonatomic, strong) FJForgetPsdViewfj *forgetPsdView;

@property (nonatomic, strong) FJForgetpsdViewModelfj *viewModel;

@end

@implementation FJForgetViewControllerfj

- (FJForgetPsdViewfj *)forgetPsdView{
    if(!_forgetPsdView){
        _forgetPsdView = NSMainBundleName(@"FJForgetPsdViewfj_");
    }
    return _forgetPsdView;
}
- (FJForgetpsdViewModelfj *)viewModel{
    if(!_viewModel){
        _viewModel = [FJForgetpsdViewModelfj new];
    }
    return _viewModel;
}

- (void)setUpUI{
    self.title = @"找回密码";
    [self.view addSubview:self.forgetPsdView];
}

- (void)autoLayout{
    [self.forgetPsdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setUpEvent{
    @weakify(self)
    //获取验证码
    [self.forgetPsdView.nextButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(![self.viewModel.mobile validateMobile]){
            [MBProgressHUD showMBProgressHudWithTitle:@"手机格式不正确"];
            return ;
        }
        [CTRequest fj_checkPhoneWithPhone:self.viewModel.mobile callback:^(id data, CLRequest *request, CTNetError error) {
            @strongify(self)
            if(error){
                FJGetCodeViewControllerfj *vc = [FJGetCodeViewControllerfj new];;
                vc.mobile = self.viewModel.mobile;
                vc.eventKind = CTEventKindForgetpsd;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                [MBProgressHUD showMBProgressHudWithTitle:@"手机号未注册"];
            }
        }];
    }];
}


- (void)bindViewModel{
    RAC(self.viewModel,mobile) = self.forgetPsdView.mobileTfd.cl_textSignal;
    RAC(self.forgetPsdView.nextButton,enabled) = self.viewModel.validNextSignal;
}
@end
