//
//  CTGetCodeViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGetCodeViewController.h"

#import "CTSetPasswordViewController.h"

#import "CTGetCodeView.h"

#import "CTGetCodeViewModel.h"

@interface CTGetCodeViewController ()

@property (nonatomic, strong) CTGetCodeView *getCodeView;

@property (nonatomic, strong) CTGetCodeViewModel *viewModel;

@end

@implementation CTGetCodeViewController

- (CTGetCodeView *)getCodeView{
    if(!_getCodeView){
        _getCodeView = NSMainBundleName(@"CTGetCodeView_");
    }
    return _getCodeView;
}

- (CTGetCodeViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [CTGetCodeViewModel new];
    }
    return _viewModel;
}

- (void)setUpUI{
    self.title = GetEventTitleStr(_eventKind);
    [self.view addSubview:self.getCodeView];
    if(_eventKind == CTEventKindWithDraw){
       self.getCodeView.phoneTfd.enabled = NO;
       self.getCodeView.phoneTfd.text = self.mobile;
       self.getCodeView.nextButton.layer.cornerRadius = 23;
    }
}

- (void)reloadView{
    self.getCodeView.phoneTfd.text = self.mobile;
    //self.getCodeView.phoneTfd.enabled = !(self.eventKind == CTEventKindRegister);
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
        [CTRequest smsSendWithPhone:self.viewModel.mobile type:GetSendCodeStrForEventKind(self.eventKind) callback:^(id data, CLRequest *request, CTNetError error) {
            @strongify(self)
            if(!error){
                [MBProgressHUD showMBProgressHudWithTitle:@"发送成功"];
                [self.getCodeView.getCodeButton startTimer];
            }
        }];
    }];
    [self.getCodeView.nextButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        CTSetPasswordViewController *vc = [CTSetPasswordViewController new];
        vc.eventKind = self.eventKind;
        vc.mobile = self.viewModel.mobile;
        vc.inviteCode = self.inviteCode;
        vc.verCode = self.viewModel.code;
        vc.nickname = self.nickname;
        vc.iconurl = self.iconurl;
        vc.completed = self.completed;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
}

- (void)bindViewModel{
    RAC(self.viewModel,code) = self.getCodeView.codeTfd.rac_textSignal;
    RAC(self.viewModel,mobile) = self.getCodeView.phoneTfd.cl_textSignal;
    RAC(self.getCodeView.nextButton,enabled) = self.viewModel.validNextSignal;
}


@end
