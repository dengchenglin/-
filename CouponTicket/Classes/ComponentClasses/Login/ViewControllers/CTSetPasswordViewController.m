//
//  CTSetPasswordViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSetPasswordViewController.h"

#import "CTSetPasswordView.h"

#import "CTSetPasswordViewModel.h"

@interface CTSetPasswordViewController ()

@property (nonatomic, strong) CTSetPasswordView *passwordView;

@property (nonatomic, strong) CTSetPasswordViewModel *viewModel;

@end

@implementation CTSetPasswordViewController

- (CTSetPasswordView *)passwordView{
    if(!_passwordView){
        _passwordView = NSMainBundleName(@"CTSetPasswordView_");
    }
    return _passwordView;
}

- (CTSetPasswordViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [CTSetPasswordViewModel new];
    }
    return _viewModel;
}

- (void)setUpUI{
    self.title = GetEventTitleStr(_eventKind);
    [self.view addSubview:self.passwordView];
}

- (void)autoLayout{
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.passwordView.doneButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(!self.viewModel.psdConsistented){
            [MBProgressHUD showMBProgressHudWithTitle:@"密码不一致"];
            return ;
        }
        if(self.completed){
            self.completed();
        }
    }];
}

- (void)bindViewModel{
    RAC(self.viewModel,password) = self.passwordView.passwordTfd.rac_textSignal;
    RAC(self.viewModel,repassword) = self.passwordView.repasswordTfd.rac_textSignal;
    RAC(self.passwordView.doneButton,enabled) = self.viewModel.validRegisterSignal;
}

@end
