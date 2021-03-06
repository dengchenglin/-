//
//  CTAdviseViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/30.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTAdviseViewController.h"

#import "CTContentInputView.h"

#import "CTUpdateImageView.h"

#import "CTDoneButton.h"

#import "CTNetworkEngine+Member.h"

@interface CTAdviseViewController ()

@property (nonatomic, strong) CTContentInputView *contentInputView;

@property (nonatomic, strong) CTUpdateImageView *updateImageView;

@property (nonatomic, strong) CTDoneButton *submitButton;

@end

@implementation CTAdviseViewController

- (CTContentInputView *)contentInputView{
    if(!_contentInputView){
        _contentInputView = NSMainBundleClass(CTContentInputView.class);
        _contentInputView.maxCount = 200;
    }
    return _contentInputView;
}

- (CTUpdateImageView *)updateImageView{
    if(!_updateImageView){
        _updateImageView = NSMainBundleClass(CTUpdateImageView.class);
    }
    return _updateImageView;
}

- (CTDoneButton *)submitButton{
    if(!_submitButton){
        _submitButton = [[CTDoneButton alloc]init];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
    
    }
    return _submitButton;
}

- (void)setUpUI{
    self.title = @"意见反馈";
    self.scrollViewAvailable = YES;
    self.navigationBarStyle = CTNavigationBarWhite;
    self.view.backgroundColor = CTBackGroundGrayColor;
    [self.autoLayoutContainerView addSubview:self.contentInputView];
    [self.autoLayoutContainerView addSubview:self.updateImageView];
    [self.autoLayoutContainerView addSubview:self.submitButton];
    
}

- (void)autoLayout{
    [self.contentInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(150);
    }];
    [self.updateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentInputView.mas_bottom);
        make.left.right.mas_equalTo(0);
    }];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.updateImageView.mas_bottom).offset(25);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(46);
        make.bottom.mas_equalTo(0);
    }];
    self.submitButton.layer.cornerRadius = 23;
}


- (void)setUpEvent{
    @weakify(self)
    [self.submitButton touchUpInsideSubscribeNext:^(id x) {
       @strongify(self)
        if(!self.contentInputView.textView.text.wipSpace.length){
            [MBProgressHUD showMBProgressHudWithTitle:@"请输入文字内容"];
            return ;
        }
        [CTRequest fj_viewSaveWithDetail:self.contentInputView.textView.text img:self.updateImageView.photosView.imgs callback:^(id data, CLRequest *request, CTNetError error) {
            if(!error){
                [MBProgressHUD showMBProgressHudWithTitle:@"意见反馈成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }];
}
@end
