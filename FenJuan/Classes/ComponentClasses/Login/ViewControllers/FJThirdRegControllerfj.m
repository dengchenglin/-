//
//  CTThirdRegController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/9.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJThirdRegControllerfj.h"

#import "LMSegmentedControl.h"

#import "CTRegisterView.h"

#import "FJBindPhoneViewfj.h"

#import "FJRegisterViewModelfj.h"

#import "FJGetCodeViewControllerfj.h"

#import "FJBindPhoneViewModelfj.h"

#import "QCodeHelper.h"

@interface CTThirdNewRegController:CTLoginBaseViewController

@property (nonatomic, strong) CTRegisterView *registerView;

@property (nonatomic, strong) FJRegisterViewModelfj *viewModel;

@property (nonatomic, assign) CTEventKind eventKind;

@property (nonatomic, strong) CTUMSocialUserInfoResponse *response;

@end

@implementation CTThirdNewRegController

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
    [self.view addSubview:self.registerView];
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
        [CTRequest fj_checkIvcodeOrPhoneWithIvCode:self.viewModel.inviteCode phone:self.viewModel.mobile callback:^(id data, CLRequest *request, CTNetError error) {
            @strongify(self)
            if(!error){
                FJGetCodeViewControllerfj *vc = [FJGetCodeViewControllerfj new];
                vc.mobile = self.viewModel.mobile.wipSpace;
                vc.inviteCode = self.viewModel.inviteCode.wipSpace;
                vc.eventKind = _eventKind;
                vc.response = self.response;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
               NSInteger status = [data[@"status"] integerValue];
                if(status == 102){
                    [[[UIAlertView alloc]initWithTitle:@"该账号已被注册，请选择“老用户绑定”" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil] show];
                }
            }
        }];

    }];
    
}
@end

@interface CTThirdOldRegController:CTLoginBaseViewController

@property (nonatomic, strong) FJBindPhoneViewfj *bindPhoneView;
@property (nonatomic, strong) FJBindPhoneViewModelfj *viewModel;

@property (nonatomic, assign) CTEventKind eventKind;

@property (nonatomic, strong) CTUMSocialUserInfoResponse *response;

@end

@implementation CTThirdOldRegController

- (FJBindPhoneViewfj *)bindPhoneView{
    if(!_bindPhoneView){
        _bindPhoneView = NSMainBundleClass(FJBindPhoneViewfj.class);
    }
    return _bindPhoneView;
}

- (FJBindPhoneViewModelfj *)viewModel{
    if(!_viewModel){
        _viewModel = [FJBindPhoneViewModelfj new];
    }
    return _viewModel;
}

- (void)setUpUI{
    [self.view addSubview:self.bindPhoneView];
}

- (void)autoLayout{
    [self.bindPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setUpEvent{
    @weakify(self)
    //获取验证码
    [self.bindPhoneView.nextButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(![self.viewModel.mobile validateMobile]){
            [MBProgressHUD showMBProgressHudWithTitle:@"手机格式不正确"];
            return ;
        }
        [CTRequest fj_checkPhoneWithPhone:self.viewModel.mobile showErrorHud:NO callback:^(id data, CLRequest *request, CTNetError error) {
            @strongify(self)
            if(error){
                FJGetCodeViewControllerfj *vc = [FJGetCodeViewControllerfj new];;
                vc.mobile = self.viewModel.mobile;
                vc.eventKind = self.eventKind;
                vc.response = self.response;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
                [[[UIAlertView alloc]initWithTitle:@"手机号尚未注册,请选择“新用户注册”" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil] show];
            }
        }];
    }];
}


- (void)bindViewModel{
    RAC(self.viewModel,mobile) = self.bindPhoneView.mobileTfd.cl_textSignal;
    RAC(self.bindPhoneView.nextButton,enabled) = self.viewModel.validNextSignal;
}

@end

@interface FJThirdRegControllerfj ()<LMSegmentedControlDelegate>

@property (nonatomic, strong) LMSegmentedControl *segmentedControl;

@end

@implementation FJThirdRegControllerfj

- (LMSegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        _segmentedControl = [[LMSegmentedControl alloc]init];
        _segmentedControl.delegate = self;
        _segmentedControl.textFont = CTPsmFont(16);
        _segmentedControl.titleNormalColor =  _segmentedControl.titleNormalColor = RGBColor(153, 153, 153);
        _segmentedControl.segmentedControlType = LMSegmentedControlAuto;
        _segmentedControl.selectedLineWidth = 20;
        _segmentedControl.selectedLineHeight = 4;
        _segmentedControl.titleSelectedColor = RGBColor(50, 50, 50);
        _segmentedControl.selectedLineColor = RGBColor(255, 97, 36);
    }
    return _segmentedControl;
}



- (void)setUpUI{
    self.title = GetEventTitleStr(_eventKind);
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.segmentedControl];
    self.contentInsets = UIEdgeInsetsMake(40, 0, 0, 0);
}

- (void)autoLayout{
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
}
- (void)reloadView{
    dispatch_async(dispatch_get_main_queue(), ^{
         self.segmentedControl.titles = @[@"新用户注册",@"老用户绑定"];
    });
   
    CTThirdNewRegController *vc1 = [CTThirdNewRegController new];
    vc1.eventKind = _eventKind;
    vc1.response = _response;
    
    CTThirdOldRegController *vc2 = [CTThirdOldRegController new];
    if(_eventKind == CTEventKindQQRegister){
        vc2.eventKind = CTEventKindQQBind;
    }
    else if (_eventKind == CTEventKindWechatRegister){
        vc2.eventKind = CTEventKindWechatBind;
    }
    vc2.response = _response;
    self.viewControllers = @[vc1,vc2];
}

- (void)pageController:(CTPageController *)pageController didScrollToIndex:(NSInteger)index{
    [self.segmentedControl scrollToIndex:index];
}

- (void)segmentedControl:(LMSegmentedControl *)segmentedControl didSelectedInbdex:(NSUInteger)index{
    [self scrollToIndex:index];
}
@end




