//
//  CTAlipayBoundViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAlipayBoundViewController.h"

#import "CTGetCodeViewController.h"

#import "CTAlipayBoundView.h"

#import "CTAlipayBoundViewModel.h"

#import "CTNetworkEngine+Cash.h"

@interface CTAlipayBoundViewController ()

@property (nonatomic, strong) CTAlipayBoundView *boundView;

@property (nonatomic, strong) CTAlipayBoundViewModel *viewModel;

@end

@implementation CTAlipayBoundViewController

- (CTAlipayBoundView *)boundView{
    if(!_boundView){
        _boundView = NSMainBundleName(@"CTAlipayBoundView_");
    }
    return _boundView;
}

- (CTAlipayBoundViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [CTAlipayBoundViewModel new];
    }
    return _viewModel;
}


- (void)setUpUI{
    self.title = @"支付宝绑定";
    [self.view addSubview:self.boundView];
}

- (void)autoLayout{
    [self.boundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)reloadView{

}

- (void)bindViewModel{
    RAC(self.viewModel,account) = self.boundView.accountTfd.cl_textSignal;
    RAC(self.viewModel,name) = self.boundView.nameTfd.cl_textSignal;
    RAC(self.boundView.boundButton,enabled) = self.viewModel.validBoundSignal;
}
- (void)setUpEvent
{
    @weakify(self)
    //绑定
    void(^boundBlock)(void) = ^{
         @strongify(self)
        [MBProgressHUD showMBProgressHudWithTitle:@"绑定成功" hideAfterDelay:1.0 complited:^{
            if(self.completed){
                self.completed();
            }
        }];
    };
    [self.boundView.boundButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(!self.viewModel.account.length){
            [MBProgressHUD showMBProgressHudWithTitle:@"请输入支付宝账号"];
            return ;
        }
        if(!self.viewModel.name.length){
            [MBProgressHUD showMBProgressHudWithTitle:@"请输入支付宝账号对应的真实姓名"];
            return ;
        }
        [CTRequest accountSaveWithAccount:self.viewModel.account username:self.viewModel.name phone:nil smsCode:nil callback:^(id data, CLRequest *request, CTNetError error) {
            if(!error){
                [CTAppManager user].ishas_cash_account = YES;
                if([CTAppManager user].ishas_pay_pwd){
                    boundBlock();
                }
                else{
                    [[CTModuleManager loginService]pushWithdrawSetpsdFromViewController:self mobile:[CTAppManager user].phone completed:^{
                        @strongify(self)
                        [self.navigationController popToViewController:self animated:YES];
                        boundBlock();
                    }];
                }
            }
        }];
    }];
}

@end
