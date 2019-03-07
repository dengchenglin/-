//
//  CTWithdrawViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTWithdrawViewController.h"

#import "CTWithdrawAlipayInfoView.h"

#import "CTWithDrawInputView.h"

#import "CTCanValidButton.h"

#import "CTWithdrawViewModel.h"

#import "CTAlertHelper+WithdrawPsd.h"

#import "CTAlertHelper+WithdrawSuccess.h"

#import "CTWithdrawModifyAlipayView.h"

@interface CTWithdrawViewController ()

@property (nonatomic, strong) CTWithdrawAlipayInfoView *alipayInfoView;

@property (nonatomic, strong) CTWithDrawInputView *withDrawInputView;

@property (nonatomic, strong) CTCanValidButton *doneButton;

@property (nonatomic, strong) CTWithdrawModifyAlipayView *modifyView;

@property (nonatomic, strong) CTWithdrawViewModel *viewModel;

@end

@implementation CTWithdrawViewController

- (CTWithdrawAlipayInfoView *)alipayInfoView{
    if(!_alipayInfoView){
        _alipayInfoView = NSMainBundleClass(CTWithdrawAlipayInfoView.class);
    }
    return _alipayInfoView;
}

- (CTWithDrawInputView *)withDrawInputView{
    if(!_withDrawInputView){
        _withDrawInputView = NSMainBundleClass(CTWithDrawInputView.class);
    }
    return _withDrawInputView;
}

- (CTCanValidButton *)doneButton{
    if(!_doneButton){
        _doneButton = [CTCanValidButton buttonWithType:UIButtonTypeCustom];
        [_doneButton setBackgroundImage:[UIImage imageWithColor:RGBColor(200, 200, 200)] forState:UIControlStateDisabled];
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        _doneButton.layer.cornerRadius = 23;
        _doneButton.clipsToBounds = YES;
        [_doneButton setTitle:@"立即提现" forState:UIControlStateNormal];
    }
    return _doneButton;
}

- (CTWithdrawModifyAlipayView *)modifyView{
    if(!_modifyView){
        _modifyView = NSMainBundleClass(CTWithdrawModifyAlipayView.class);
    }
    return _modifyView;
}

- (CTWithdrawViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [CTWithdrawViewModel new];
    }
    return _viewModel;
}

- (void)setUpUI{
    self.title = @"立即提现";
    self.navigationBarStyle = CTNavigationBarWhite;
    self.scrollViewAvailable = YES;
    self.scrollView.backgroundColor = CTBackGroundGrayColor;
    [self.autoLayoutContainerView addSubview:self.alipayInfoView];
    [self.autoLayoutContainerView addSubview:self.withDrawInputView];
    [self.autoLayoutContainerView addSubview:self.doneButton];
    [self.autoLayoutContainerView addSubview:self.modifyView];

}

- (void)autoLayout{
    [self.alipayInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(72);
    }];
    [self.withDrawInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.alipayInfoView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(140);
    }];
    [self.doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.withDrawInputView.mas_bottom).offset(25);
        make.left.mas_equalTo(28);
        make.right.mas_equalTo(-28);
        make.height.mas_equalTo(44);
    }];
    [self.modifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.doneButton.mas_bottom).offset(40);
        make.width.mas_equalTo(200);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)reloadView{
    self.viewModel.withdrawAccount = [CTAppManager user].withInfo.account;
    self.viewModel.withdrawName = [CTAppManager user].withInfo.name;
}

- (void)bindViewModel{
    @weakify(self)
    RAC(self.alipayInfoView.accountLabel,text) = RACObserve(self.viewModel, withdrawAccount);
    RAC(self.alipayInfoView.nameLabel,text) = RACObserve(self.viewModel, withdrawName);
    RAC(self.viewModel,money) = self.withDrawInputView.moneyTextField.cl_textSignal;
    self.withDrawInputView.balanceNoticeLabel.text = [NSString stringWithFormat:@"可用余额 %.2f元",[CTAppManager user].money.floatValue];
    RAC(self.doneButton,enabled) = [self.withDrawInputView.moneyTextField.cl_textSignal map:^id _Nullable(NSString * value) {
        return @(value.length && [CTAppManager user].money.floatValue >= value.floatValue);
    }];
    
    [self.withDrawInputView.moneyTextField.cl_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        self.withDrawInputView.balanceNoticeLabel.text = (x.floatValue > [CTAppManager user].money.floatValue)?@"金额已超过可提现余额":[NSString stringWithFormat:@"可用余额 %.2f元",[CTAppManager user].money.floatValue];
        self.withDrawInputView.balanceNoticeLabel.textColor = (x.floatValue > [CTAppManager user].money.floatValue)?[UIColor colorWithHexString:@"#F5A623"]:[UIColor colorWithHexString:@"#6F6F6F"];
    }];

    
}

- (void)setUpEvent{
    @weakify(self)
    [self.doneButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [self.view endEditing:YES];
        [CTAlertHelper showPayPasswordViewWithCallback:^(NSString *password) {
            NSLog(@"%@",password);
            dispatch_async(dispatch_get_main_queue(), ^{
                [CTAlertHelper showWithdrawSuccessViewWithCallback:^(NSUInteger buttonIndex) {
                    @strongify(self)
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            });
        }];
    }];

    [self.alipayInfoView addActionWithBlock:^(id target) {
        @strongify(self)
        [self.view endEditing:YES];
        [[CTModuleManager loginService]pushBoundAlipayFromViewController:self completed:^{
            @strongify(self)
            [self.navigationController popToViewController:self animated:YES];
            [self reloadView];
        }];
    }];
    [self.modifyView addActionWithBlock:^(id target) {
        @strongify(self)
        [self.view endEditing:YES];
        [[CTModuleManager loginService]pushBoundAlipayFromViewController:self completed:^{
            @strongify(self)
            [self.navigationController popToViewController:self animated:YES];
            [self reloadView];
        }];
    }];
}

@end
