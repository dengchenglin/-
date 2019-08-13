//
//  CTAlipayBoundViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJAlipayBoundViewControllerfj.h"

#import "FJGetCodeViewControllerfj.h"

#import "FJAlipayBoundViewfj.h"

#import "FJAlipayBoundViewModelfj.h"


@interface FJAlipayBoundViewControllerfj ()

@property (nonatomic, strong) FJAlipayBoundViewfj *boundView;

@property (nonatomic, strong) FJAlipayBoundViewModelfj *viewModel;

@end

@implementation FJAlipayBoundViewControllerfj

- (FJAlipayBoundViewfj *)boundView{
    if(!_boundView){
        _boundView = NSMainBundleName(@"FJAlipayBoundViewfj_");
    }
    return _boundView;
}

- (FJAlipayBoundViewModelfj *)viewModel{
    if(!_viewModel){
        _viewModel = [FJAlipayBoundViewModelfj new];
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
        
        FJGetCodeViewControllerfj *vc = [FJGetCodeViewControllerfj new];;
        vc.mobile = [CTAppManager user].phone;
        vc.eventKind = CTEventKindBindAlipay;
        vc.cashAccount = self.viewModel.account;
        vc.cashName = self.viewModel.name;
        vc.completed = self.completed;
        [self.navigationController pushViewController:vc animated:YES];

    }];
}

@end
