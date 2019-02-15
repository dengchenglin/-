//
//  CTSharePopView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSharePopView.h"

@interface CTSharePopView()

@property (nonatomic, copy) NSArray <NSString *> *types;

@property (nonatomic, copy) UIImage *image;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) UIImageView *backgroundView;

@property (nonatomic, strong) CTSharePopContainerView *containerView;

@end

@implementation CTSharePopView

ViewInstance(setUp)

+ (void)showSharePopViewWithTypes:(NSArray <NSString *>*)types image:(UIImage *)image title:(NSString *)title url:(NSString *)url{
    CTSharePopView *view = [CTSharePopView new];
    view.types = types;
    view.image = image;
    view.title = title;
    view.url = url;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
}

- (void)setUp{
    _backgroundView = [UIImageView new];
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.alpha = 0.0;
    [self addSubview:_backgroundView];
    
    _containerView = NSMainBundleClass(CTSharePopContainerView.class);
    [self addSubview:_containerView];
    
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    @weakify(self)
    [_backgroundView addActionWithBlock:^(id  _Nonnull target) {
        @strongify(self)
        [self removeFromSuperview];
    }];
    
    [_containerView.cancelButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [self removeFromSuperview];
    }];
    [_containerView setClickItemBlock:^(NSInteger index) {
        @strongify(self)
        [self removeFromSuperview];
        if(index == 2){
            [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            [self.image saveToPhotosWithCompleted:^(BOOL success) {
                [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
                [MBProgressHUD showMBProgressHudWithTitle:success?@"保存成功":@"保存失败"];
            }];
        }

    }];
}

- (void)setTypes:(NSArray<NSString *> *)types{
    _types = types;
    _containerView.shareTypes = _types;
    CGFloat containerHeight = [CTSharePopContainerView heightForItemCount:_types.count]  + 60 + 58;
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(containerHeight);
    }];
    [self layoutIfNeeded];
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundView.alpha = 0.6;
            [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(0);
            }];
            [self layoutIfNeeded];
        }];
    });
}



@end
