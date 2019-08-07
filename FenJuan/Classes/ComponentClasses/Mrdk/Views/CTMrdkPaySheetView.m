//
//  CTMrdkPaySheetView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMrdkPaySheetView.h"
static int CTMrdkPaySheetViewKey;
@implementation CTMrdkPayInfo

@end

@interface CTMrdkPaySheetView()
@property (nonatomic, copy) void(^completed)(CTMrdkPayInfo *info);
@end

@implementation CTMrdkPaySheetView

+ (CTMrdkPaySheetView *)showPaySheetViewWithCompleted:(void(^)(CTMrdkPayInfo *info))completed{
    
    [self hiddenPaySheetView];
    
    UIView *contanierView = [UIView new];
    [[UIApplication sharedApplication].keyWindow addSubview:contanierView];
    [contanierView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    objc_setAssociatedObject([UIApplication sharedApplication].keyWindow, &CTMrdkPaySheetViewKey, contanierView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIImageView *backgroundView = [[UIImageView alloc]init];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    [contanierView addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    CTMrdkPaySheetView *sheet = NSMainBundleClass(CTMrdkPaySheetView.class);
    sheet.completed = completed;
    [contanierView addSubview:sheet];
    CGSize size = [sheet systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)];
    [sheet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(size.height);
        make.left.right.mas_equalTo(0);
    }];
    [sheet.superview layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [sheet mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
        }];
        backgroundView.alpha = 0.5;
        [sheet.superview layoutIfNeeded];
    }];
    
    
    [backgroundView addActionWithBlock:^(UIView * target) {
        [contanierView removeFromSuperview];
    }];
    return sheet;
}

+ (void)hiddenPaySheetView{
    UIView *v = objc_getAssociatedObject([UIApplication sharedApplication].keyWindow, &CTMrdkPaySheetViewKey);
    if(v){
        [v removeFromSuperview];
    }
}

- (void)awakeFromNib{
    [super awakeFromNib];
    @weakify(self)
    [self.cancelButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [CTMrdkPaySheetView hiddenPaySheetView];
    }];
    [self.doneButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        CTMrdkPayInfo *info = [CTMrdkPayInfo new];
        info.money = self.amountTypeView.amount;
        info.payType = self.payTypeView.payType;
        if(self.completed){
            self.completed(info);
        }
        [CTMrdkPaySheetView hiddenPaySheetView];
    }];
}

@end
