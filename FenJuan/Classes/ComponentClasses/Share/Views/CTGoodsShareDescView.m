//
//  CTGoodsShareDescView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodsShareDescView.h"
#import "CTSharePopupView.h"
#import "CTGoodsPreview.h"

@interface CTGoodsShareDescView()

@property (nonatomic, copy) NSString *cpyText;
@end

@implementation CTGoodsShareDescView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.hidden = YES;
    @weakify(self)
    [self.imgsContainerView setClickItemBlock:^{
        @strongify(self)
        if(self.imgsContainerView.currentImages.count){
            self.imgCountLabel.text = [NSString stringWithFormat:@"已选择%lu张图片",self.imgsContainerView.currentImages.count];
        }
        else{
            self.imgCountLabel.text = @"";
        }
    }];
    
    [self.tklButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(!self.linkButton.selected && !self.ivCodeButton.selected && self.tklButton.selected){
            [MBProgressHUD showMBProgressHudWithTitle:@"最少选择一种分享方式"];
            return ;
        }
        self.tklButton.selected = !self.tklButton.selected;
        [self resetCopyText];
    }];
    [self.linkButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(self.linkButton.selected && !self.ivCodeButton.selected && !self.tklButton.selected){
            [MBProgressHUD showMBProgressHudWithTitle:@"最少选择一种分享方式"];
            return ;
        }
        self.linkButton.selected = !self.linkButton.selected;
        [self resetCopyText];
    }];
    [self.ivCodeButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(!self.linkButton.selected && self.ivCodeButton.selected && !self.tklButton.selected){
            [MBProgressHUD showMBProgressHudWithTitle:@"最少选择一种分享方式"];
            return ;
        }
        self.ivCodeButton.selected = !self.ivCodeButton.selected;
        [self resetCopyText];
    }];
    
    [self.cpyButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
       
        pasteboard.string =  self.cpyText;
         [pasteboard updateCount];
        [MBProgressHUD showMBProgressHudWithTitle:@"复制成功"];
    }];
    [self.shareButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        if(!self.shareImages.count){
            [MBProgressHUD showMBProgressHudWithTitle:@"请选择图片"];
            return ;
        }
 
        [CTGoodsPreview createGoodsPreviewWithImages:self.shareImages imgs:self.imgsContainerView.currentImgs model:self.viewModel.model completed:^(NSArray<UIImage *> * _Nonnull images) {
            UIViewController *vc = [UIUtil getCurrentViewController];
            [CTSharePopupView showSharePopupWithImages:images onView:vc.view];
        }];
       
    }];
    
    //默认设置
    self.tklButton.selected = YES;
    
}
- (void)setViewModel:(CTGoodsViewModel *)viewModel{
    _viewModel = viewModel;
    self.hidden = NO;
    _imgsContainerView.imgs = _viewModel.model.goods_image;
    _titleLabel.text = _viewModel.model.goods_title;
    if(_viewModel.model.shopKind == CTShopTb){
        _tklButton.hidden = NO;
    }
    else{
        _tklButton.hidden = YES;
        _tklButton.selected = NO;
        _linkButton.selected = YES;
        [_linkButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.top.mas_equalTo(0);
            make.right.mas_equalTo(_ivCodeButton.mas_left);
        }];
        [_ivCodeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(_linkButton.mas_width);
        }];
    }
    
    [self resetCopyText];
}

- (void)resetCopyText{
    NSMutableString *string = [NSMutableString string];
    NSString *text1 = [NSString stringWithFormat:@"【券后价】%@元\n",_viewModel.model.coupon_price];
    NSString *text2 = [NSString stringWithFormat:@"【免费下载优券下单】再返还%@元\n",_viewModel.model.commission_money];
    NSString *text3 = [NSString stringWithFormat:@"【下单链接】%@",_viewModel.model.order_url];
    if(text3.length > 200){
        text3 = [text3 substringWithRange:NSMakeRange(0, 200)];
    }
    NSString *text4 = [NSString stringWithFormat:@"【官方登录邀请码】%@",_viewModel.model.iv_code];
    NSString *text5 = [NSString stringWithFormat:@"【淘口令】长按复制这段描述 {%@}打开【淘宝】即可抢购",_viewModel.model.tpwd];
 
    [string appendString:text1];
    [string appendString:text2];
    if(self.linkButton.selected){
        [string appendFormat:@"%@\n",text3];
    }
    if(self.ivCodeButton.selected){
        [string appendFormat:@"%@\n",text4];
    }
    if(self.tklButton.selected){
        [string appendFormat:@"%@",text5];
    }
    
    self.cpyText = [string copy];
    self.tklTextLabel.text = _cpyText;
}

- (NSArray<UIImage *> *)shareImages{
    return _imgsContainerView.currentImages;
}

@end
