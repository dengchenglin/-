//
//  CTRegisterViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJRegisterViewControllerfj.h"

#import "CTRegisterView.h"

#import "FJRegisterViewModelfj.h"

#import "FJGetCodeViewControllerfj.h"

#import "QCodeHelper.h"

@interface FJRegisterViewControllerfj ()

@property (nonatomic, strong) CTRegisterView *registerView;

@property (nonatomic, strong) FJRegisterViewModelfj *viewModel;


@end

@implementation FJRegisterViewControllerfj

- (CTRegisterView *)registerView{
    if(!_registerView){
        _registerView = NSMainBundleName(@"CTRegisterView_");
    }
    return _registerView;
}

- (FJRegisterViewModelfj *)viewModel{
    if(!_viewModel){
        _viewModel = [FJRegisterViewModelfj new];
    }
    return _viewModel;
}

- (void)setUpUI{
    [self setLeftDefaultItem];
    self.title = GetEventTitleStr(_eventKind);
    [self.view addSubview:self.registerView];
    self.registerView.inviteCodeTfd.text = _inviteCode;
}

- (void)autoLayout{
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)bindViewModel{
    RAC(self.viewModel,inviteCode) = self.registerView.inviteCodeTfd.cl_textSignal;
    RAC(self.viewModel,mobile) = self.registerView.phoneTfd.cl_textSignal;
    RAC(self.registerView.nextButton,enabled) = self.viewModel.validNextSignal;
}

- (void)setUpEvent
{
    @weakify(self)
    //扫一扫
    [self.registerView.scanButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [QCodeHelper showQcodeFromViewController:self discernCallback:^(NSString *result) {
            @strongify(self)
            self.registerView.inviteCodeTfd.text = [RegalurUtil jiexi:@"iv_code" webaddress:result];
        }];
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
        [CTRequest fj_checkIvcodeOrPhoneWithIvCode:self.viewModel.inviteCode phone:self.viewModel.mobile.wipSpace callback:^(id data, CLRequest *request, CTNetError error) {
            @strongify(self)
            if(!error){
                
                FJGetCodeViewControllerfj *vc = [FJGetCodeViewControllerfj new];
                vc.mobile = self.viewModel.mobile.wipSpace;
                vc.inviteCode = self.viewModel.inviteCode.wipSpace;
                vc.eventKind = self.eventKind;
                vc.response = self.response;
                vc.completed = self.completed;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];

    }];
    
}

@end
