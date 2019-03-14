//
//  CTRegisterViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTRegisterViewController.h"

#import "CTRegisterView.h"

#import "CTRegisterViewModel.h"

#import "CTGetCodeViewController.h"

@interface CTRegisterViewController ()

@property (nonatomic, strong) CTRegisterView *registerView;

@property (nonatomic, strong) CTRegisterViewModel *viewModel;


@end

@implementation CTRegisterViewController

- (CTRegisterView *)registerView{
    if(!_registerView){
        _registerView = NSMainBundleName(@"CTRegisterView_");
    }
    return _registerView;
}

- (void)setUpUI{
    [self setLeftDefaultItem];
    self.title = GetEventTitleStr(_eventKind);
    [self.view addSubview:self.registerView];
}

- (void)autoLayout{
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)bindViewModel{
    RAC(self.viewModel,inviteCode) = self.registerView.inviteCodeTfd.cl_textSignal;
    RAC(self.viewModel,mobile) = self.registerView.phoneTfd.rac_textSignal;
    RAC(self.registerView.nextButton,enabled) = self.viewModel.validNextSignal;
}

- (void)setUpEvent
{
    @weakify(self)
    //扫一扫
    [self.registerView.scanButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        
    }];
    //下一步
    [self.registerView.nextButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(!self.viewModel.inviteCode.wipSpace.length){
            [MBProgressHUD showMBProgressHudWithTitle:@"邀请码不能为空"];
            return ;
        }
        if(![self.viewModel.mobile.wipSpace validateMobile]){
            [MBProgressHUD showMBProgressHudWithTitle:@"手机格式不正确"];
            return ;
        }
        [CTRequest checkPhoneWithPhone:self.viewModel.mobile callback:^(id data, CLRequest *request, CTNetError error) {
            if(!error){
                CTGetCodeViewController *vc = [CTGetCodeViewController new];
                vc.mobile = self.viewModel.mobile.wipSpace;
                vc.inviteCode = self.viewModel.inviteCode.wipSpace;
                vc.eventKind = _eventKind;
                vc.response = self.response;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];

    }];
    
}
@end
