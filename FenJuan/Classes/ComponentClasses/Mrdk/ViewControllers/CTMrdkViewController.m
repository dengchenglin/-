//
//  CTMrdkViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMrdkViewController.h"
#import "CTMrdkAmountView.h"
#import "CTMrdkInfoView.h"
#import "CTMrdkPaySheetView.h"
#import "CTMrdkShareView.h"
#import "CTSharePopupView.h"

#import "CTNetworkEngine+Mrdk.h"

#import "FJMrdkIndexModel_fj.h"

#import "CTMarkPayHelper.h"

#import "CTAlertHelper+MrdkShareSuccess.h"

#import "CTMrdkPaySuccessViewController.h"
#import "CTMrdkMyRecordViewController.h"
@interface CTMrdkViewController()
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) CTMrdkAmountView *amountView;
@property (nonatomic, strong) CTMrdkInfoView *infoView;
@property (nonatomic, strong) FJMrdkIndexModel_fj *model;
@end
@implementation CTMrdkViewController
- (UIImageView *)titleImageView{
    if(!_titleImageView){
        _titleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_puch_font"]];
        
    }
    return _titleImageView;
}
- (CTMrdkAmountView *)amountView{
    if(!_amountView){
        _amountView = NSMainBundleClass(CTMrdkAmountView.class);
    }
    return _amountView;
}
- (CTMrdkInfoView *)infoView{
    if(!_infoView){
        _infoView = NSMainBundleClass(CTMrdkInfoView.class);
    }
    return _infoView;
}
- (void)initialize{
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"test" object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        [self request];
    }];
}
- (void)setUpUI{
    self.title = @"每日打卡";
    self.navigationBarStyle = CTNavigationBarWhite;

    self.scrollViewAvailable = YES;
    
    self.autoLayoutContainerView.layer.contents = (__bridge id)[UIImage imageNamed:@"pic_punch_background"].CGImage;
    [self.autoLayoutContainerView addSubview:self.titleImageView];
    [self.autoLayoutContainerView addSubview:self.amountView];
    [self.autoLayoutContainerView addSubview:self.infoView];
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(27);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.amountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(128);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(296);
    }];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.amountView.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(425);
        make.bottom.mas_equalTo(-60);
    }];
}
- (void)request{
    [CTRequest mrdkIndexWithCallback:^(id data, CLRequest *request, CTNetError error) {
        [self.scrollView endRefreshing];
        if(!error){
            self.model = [FJMrdkIndexModel_fj yy_modelWithDictionary:data];
           
            self.amountView.model = _model;
            self.infoView.model = _model;
        }
    }];
}


- (void)setUpEvent{
    @weakify(self)
    [self.scrollView addHeaderRefreshWithCallBack:^{
        @strongify(self)
        [self request];
    }];
    [self.amountView.doneButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(self.model.activity.activity_user_status == 1){
           CTMrdkPaySheetView *paySheet = [CTMrdkPaySheetView showPaySheetViewWithCompleted:^(CTMrdkPayInfo * _Nonnull info) {
                [CTMarkPayHelper payWithType:info.payType amount:info.money activityId:self.model.activity.Id success:^(id  _Nonnull value) {
                    CTMrdkPaySuccessViewController *vc = [CTMrdkPaySuccessViewController new];
                    vc.model = self.model;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
           }];
            paySheet.amountTypeView.cate = self.model.money_cate;
            paySheet.titleLabel.text = [NSString stringWithFormat:@"参与 %@:%@~%@",self.model.activity.signin_time_label,self.model.activity.signin_start_time_label,self.model.activity.signin_end_time_label];
        }
        else if (self.model.activity.activity_user_status == 3){
            [CTMrdkShareView createImageWithModel:self.model completed:^(UIImage * _Nonnull image) {
//                [CTSharePopupView showSharePopupWithImages:@[image] onView:nil completed:^{
//                    [CTRequest sa_signInWithCallback:^(id data, CLRequest *request, CTNetError error) {
//                        if(!error){
//                            [CTAlertHelper showMrdkShareSuccessWithCallback:nil];
//                        }
//                    }];
//                }];
            }];
        }
     
    }];
    [self.infoView.lookMoreButton addActionWithBlock:^(id target) {
        @strongify(self)
        CTMrdkMyRecordViewController *vc = [CTMrdkMyRecordViewController new];
        vc.indexModel = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}
@end
