//
//  CTUserEditViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/8.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTUserEditViewController.h"
#import "CTEditInputView.h"
#import "CTDoneButton.h"
#import "CTNetworkEngine+Member.h"

NSString *GetEditTitleStr(CTUserEditType type){
    switch (type) {
        case CTUserEditIcon:
            return @"头像";
            break;
        case CTUserEditWX:
            return @"微信号";
            break;
        case CTUserEditQQ:
            return @"QQ号";
            break;
        case CTUserEditRemark:
            return @"添加备注";
            break;
        default:
            break;
   }
    return @"";
}

NSString *GetInfoKey(CTUserEditType type){
    switch (type) {
        case CTUserEditIcon:
            return @"headimg";
            break;
        case CTUserEditWX:
            return @"wx";
            break;
        case CTUserEditQQ:
            return @"qq";
            break;
        default:
            break;
    }
    return @"";
}

@interface CTUserEditViewController ()
@property (nonatomic, strong) CTEditInputView *infoTextView;

@property (nonatomic, strong) CTDoneButton *doneButton;

@end

@implementation CTUserEditViewController

- (CTEditInputView *)infoTextView{
    if(!_infoTextView){
        _infoTextView = NSMainBundleClass(CTEditInputView.class);
    }
    return _infoTextView;
}

- (CTDoneButton *)doneButton{
    if(!_doneButton){
        _doneButton = [CTDoneButton buttonWithType:UIButtonTypeCustom];
        [_doneButton setTitle:@"确定" forState:UIControlStateNormal];
        self.doneButton.clipsToBounds = YES;
    }
    return _doneButton;
}

- (void)setUpUI{
    self.title = GetEditTitleStr(_type);
    [self.view addSubview:self.infoTextView];
    [self.view addSubview:self.doneButton];
    if(_type == CTUserEditQQ){
        self.infoTextView.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if (_type == CTUserEditWX){
        self.infoTextView.textField.keyboardType = UIKeyboardTypeASCIICapable;
    }
}
- (void)autoLayout{
    [self.infoTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(40);
    }];
    
    [self.doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.infoTextView.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(46);
    }];
    self.doneButton.layer.cornerRadius = 23;
}
- (void)reloadView{
    self.infoTextView.textField.placeholder = [NSString stringWithFormat:@"请输入%@",GetEditTitleStr(_type)];
}

- (void)setUpEvent{
    @weakify(self)
    [self.doneButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [self.view endEditing:YES];
        if(!self.infoTextView.textField.text.length){
            [MBProgressHUD showMBProgressHudWithTitle:[NSString stringWithFormat:@"请输入%@",GetEditTitleStr(_type)]];
            return ;
        }
        if(_type == CTUserEditRemark){
            [CTRequest childRemarkSaveWithChildUid:_Id remark:self.infoTextView.textField.text callback:^(id data, CLRequest *request, CTNetError error) {
                if(!error){
                    [MBProgressHUD showMBProgressHudWithTitle:@"保存成功" hideAfterDelay:1.0 complited:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    if(self.success){
                        self.success(self.infoTextView.textField.text);
                    }
                    POST_NOTIFICATION(CTRefreshMineNotification);
                }
            }];
        }
        else{
            [CTRequest userInfoSaveWithInfo:@{GetInfoKey(_type):self.infoTextView.textField.text} callback:^(id data, CLRequest *request, CTNetError error) {
                if(!error){
                    [MBProgressHUD showMBProgressHudWithTitle:@"保存成功" hideAfterDelay:1.0 complited:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    if(self.success){
                        self.success(self.infoTextView.textField.text);
                    }
                    POST_NOTIFICATION(CTRefreshMineNotification);
                }
            }];
        }
    }];
}

@end
