//
//  CTForgetViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTForgetViewController.h"

#import "CTForgetpsdViewModel.h"

#import "CTForgetPsdView.h"

#import "CTGetCodeViewController.h"

@interface CTForgetViewController ()

@property (nonatomic, strong) CTForgetPsdView *forgetPsdView;

@property (nonatomic, strong) CTForgetpsdViewModel *viewModel;

@end

@implementation CTForgetViewController

- (CTForgetPsdView *)forgetPsdView{
    if(!_forgetPsdView){
        _forgetPsdView = NSMainBundleName(@"CTForgetPsdView_");
    }
    return _forgetPsdView;
}
- (CTForgetpsdViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [CTForgetpsdViewModel new];
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
        [CTRequest checkPhoneWithPhone:self.viewModel.mobile callback:^(id data, CLRequest *request, CTNetError error) {
            if(error){
                CTGetCodeViewController *vc = [CTGetCodeViewController new];;
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
    RAC(self.viewModel,mobile) = self.forgetPsdView.mobileTfd.rac_textSignal;
    RAC(self.forgetPsdView.nextButton,enabled) = self.viewModel.validNextSignal;
}
@end
