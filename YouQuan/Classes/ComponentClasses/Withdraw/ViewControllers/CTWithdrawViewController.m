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

#import "CTNetworkEngine+Cash.h"
#import "CTNetworkEngine+H5Url.h"

@interface CTWithdrawViewController ()

@property (nonatomic, strong) CTWithdrawAlipayInfoView *alipayInfoView;

@property (nonatomic, strong) CTWithDrawInputView *withDrawInputView;

@property (nonatomic, strong) CTCanValidButton *doneButton;

@property (nonatomic, strong) UIButton *withdrawIntroButton;

@property (nonatomic, strong) CTWithdrawModifyAlipayView *modifyView;

@property (nonatomic, strong) CTWithdrawViewModel *viewModel;

@property (nonatomic, strong) CTUser *withdrawInfo;

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
- (UIButton *)withdrawIntroButton{
    if(!_withdrawIntroButton){
        _withdrawIntroButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_withdrawIntroButton setTitle:@"查看提现说明" forState:UIControlStateNormal];
        _withdrawIntroButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_withdrawIntroButton setTitleColor:CTColor forState:UIControlStateNormal];
    }
    return _withdrawIntroButton;
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
    [self.view addSubview:self.withdrawIntroButton];
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
    
    [self.withdrawIntroButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.doneButton.mas_bottom);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    [self.modifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.withdrawIntroButton.mas_bottom).offset(40);
        make.width.mas_equalTo(200);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)reloadView{
    [self reloadViewWithInfo:[CTAppManager user]];
}

- (void)request{
    [CTRequest cashIndexWithCallback:^(id data, CLRequest *request, CTNetError error) {
        self.withdrawInfo = [CTUser yy_modelWithDictionary:data];
        [self reloadViewWithInfo:_withdrawInfo];
    }];
}
- (void)reloadViewWithInfo:(CTUser *)user{
    self.viewModel.withdrawAccount = user.cash_account;
    self.viewModel.withdrawName = user.cash_name;
    [CTAppManager user].money = user.money;
}

- (void)bindViewModel{
    @weakify(self)
    RAC(self.alipayInfoView.accountLabel,text) = RACObserve(self.viewModel, withdrawAccount);
    RAC(self.alipayInfoView.nameLabel,text) = RACObserve(self.viewModel, withdrawName);
    RAC(self.viewModel,money) = self.withDrawInputView.moneyTextField.cl_textSignal;
    self.withDrawInputView.balanceNoticeLabel.text = [NSString stringWithFormat:@"可用余额 %.2f元",[CTAppManager user].money.floatValue];
    RAC(self.doneButton,enabled) = [self.withDrawInputView.moneyTextField.cl_textSignal map:^id _Nullable(NSString * value) {
        return @(value.length && [CTAppManager user].money.floatValue >= value.floatValue && value.floatValue != 0);
    }];
    
    [self.withDrawInputView.moneyTextField.cl_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        if(x.floatValue > [CTAppManager user].money.floatValue){
            self.withDrawInputView.balanceNoticeLabel.text = @"金额已超过可提现余额";
        }
        else{
            self.withDrawInputView.balanceNoticeLabel.text = [NSString stringWithFormat:@"可用余额 %.2f元",[CTAppManager user].money.floatValue];
        }
        if(x.floatValue > [CTAppManager user].money.floatValue || x.floatValue == 0){
            self.withDrawInputView.balanceNoticeLabel.textColor = [UIColor colorWithHexString:@"#F5A623"];
        }
        else{
            self.withDrawInputView.balanceNoticeLabel.textColor= [UIColor colorWithHexString:@"#6F6F6F"];
        }
    }];

    
}

- (void)setUpEvent{
    @weakify(self)
    
    void (^withdrawActionBlock)(void) = ^{
        @strongify(self)
        [self.view endEditing:YES];
        [CTAlertHelper showPayPasswordViewWithCallback:^(NSString *password) {
            @strongify(self)
            [CTRequest cashSaveWithPaypwd:password money:self.viewModel.money callback:^(id data, CLRequest *request, CTNetError error) {
                if(!error){
                    [CTAlertHelper showWithdrawSuccessViewWithCallback:^(NSUInteger buttonIndex) {
                        @strongify(self)
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }
            }];
        }];
    };
    
    //提现按钮触发
    [self.doneButton touchUpInsideSubscribeNext:^(id x) {
        withdrawActionBlock();
    }];
    
    //修改支付账号
    [self.alipayInfoView addActionWithBlock:^(id target) {
        @strongify(self)
        [self.view endEditing:YES];
        [[CTModuleManager loginService]pushBoundAlipayFromViewController:self completed:^{
            @strongify(self)
            [self.navigationController popToViewController:self animated:YES];
            [self request];
        }];
    }];
    //修改支付宝账号
    [self.modifyView addActionWithBlock:^(id target) {
        @strongify(self)
        [self.view endEditing:YES];
        [[CTModuleManager loginService]pushBoundAlipayFromViewController:self completed:^{
            @strongify(self)
            [self.navigationController popToViewController:self animated:YES];
            [self request];
        }];
    }];
    [self.withDrawInputView setWithDrawAllBlock:^{
        withdrawActionBlock();
    }];
    //查看提现说明
    [self.withdrawIntroButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        UIViewController *webVc = [[CTModuleManager webService] pushWebFromViewController:self url:CTH5UrlForType(CTH5UrlWithdrawIntro)];
        webVc.title = @"提现说明";

    }];
}

@end
