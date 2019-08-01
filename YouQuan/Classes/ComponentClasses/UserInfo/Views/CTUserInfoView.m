//
//  CTUserInfoView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTUserInfoView.h"
#import "CTUserInfoItem.h"
#import "CTUserRemarkItem.h"
@interface CTUserInfoView ()
@property (weak, nonatomic) IBOutlet UIView *otherInfoView;

@end

@implementation CTUserInfoView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.otherInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
}

- (void)setUser:(CTUser *)user{
    _user = user;
    [_userheadImageView sd_setImageWithURL:[NSURL URLWithString:_user.headimg]];
    _usernameLabel.text = _user.nickname;
    _userlevelLabel.text = _user.level_txt;
    _userkindLabel.text = _user.fx_txt;
    _userkindLabel.hidden = !_user.fx_txt.length;
    [self reloadView];
}

- (void)reloadView{
    [self.otherInfoView removeAllSubViews];
    UIView *topView = nil;
    CGFloat height = 0;
    if(_user.phone.length){
        CTUserInfoItem *item = NSMainBundleClass(CTUserInfoItem.class);
        item.keyLabel.text = @"手机号";
        item.valueLabel.text = _user.phone;
        [self.otherInfoView addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        topView = item;
        height += 44;
    }
    if(_user.wx.length){
        CTUserInfoItem *item = NSMainBundleClass(CTUserInfoItem.class);
        item.keyLabel.text = @"微信号";
        item.valueLabel.text = _user.wx;
        [self.otherInfoView addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if(topView){
                make.top.mas_equalTo(topView.mas_bottom);
            }
            else{
                make.top.mas_equalTo(0);
            }
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        topView = item;
        height += 44;
    }
    if(_user.qq.length){
        CTUserInfoItem *item = NSMainBundleClass(CTUserInfoItem.class);
        item.keyLabel.text = @"QQ号";
        item.valueLabel.text = _user.qq;
        [self.otherInfoView addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if(topView){
                make.top.mas_equalTo(topView.mas_bottom);
            }
            else{
                make.top.mas_equalTo(0);
            }
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        topView = item;
        height += 44;
    }
    if(_user.uid != [CTAppManager user].uid){
        CTUserRemarkItem *item = NSMainBundleClass(CTUserRemarkItem.class);
        item.remarkLabel.text = _user.remark;
        [self.otherInfoView addSubview:item];
        
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if(topView){
                make.top.mas_equalTo(topView.mas_bottom);
            }
            else{
                make.top.mas_equalTo(0);
            }
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        topView = item;
        height += 44;
        
        
        @weakify(self)
        [item addActionWithBlock:^(CTUserRemarkItem *target) {
            @strongify(self)
            UIViewController *currentVc = [UIUtil getCurrentViewController];
            UIViewController *vc = [[CTModuleManager userInfoService]viewControllerForType:CTUserEditRemark Id:self.user.uid success:^(id value) {
                target.remarkLabel.text = value;
            }];
            [currentVc.navigationController pushViewController:vc animated:YES];
        }];
    }
    [self.otherInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}

@end
