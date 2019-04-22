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
        
        CTGetCodeViewController *vc = [CTGetCodeViewController new];;
        vc.mobile = [CTAppManager user].phone;
        vc.eventKind = CTEventKindBindAlipay;
        vc.cashAccount = self.viewModel.account;
        vc.cashName = self.viewModel.name;
        vc.completed = self.completed;
        [self.navigationController pushViewController:vc animated:YES];

    }];
}

@end
