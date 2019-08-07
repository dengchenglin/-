//
//  CTSharePopupView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSharePopupView.h"
#import "ShareUtil.h"
@interface CTSharePopupView()
@property (weak, nonatomic) IBOutlet UIView *saveView;
@property (weak, nonatomic) IBOutlet UIView *weChatView;
@property (weak, nonatomic) IBOutlet UIView *weChatTimeLineView;
@property (weak, nonatomic) IBOutlet UIView *qqView;
@property (weak, nonatomic) IBOutlet UIView *qZoneView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, copy) NSArray <UIImage *> *images;
@end

@implementation CTSharePopupView
- (void)awakeFromNib{
    [super awakeFromNib];
    self.scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    
    void(^checkAndRemove)(void) = ^{
        if(self.superview == [UIApplication sharedApplication].keyWindow){
            [self removeFromSuperview];
        }
    };
    
    @weakify(self)
    [self.saveView addActionWithBlock:^(id target) {
        @strongify(self)
        checkAndRemove();
        [MBProgressHUD showMBProgressHudOnView:[UIApplication sharedApplication].keyWindow];

        [self.images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj saveToPhotosWithCompleted:^(BOOL success) {
              [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
                if(success){
                    [MBProgressHUD showMBProgressHudWithTitle:@"保存成功"];
                }
             
            }];
        }];
    }];
    [self.weChatView addActionWithBlock:^(id target) {
        @strongify(self);
        checkAndRemove();
        [ShareUtil shareWithImages:self.images type:CLShareWechat completed:^{
            [self cancel:nil];
        }];
    }];
    [self.weChatTimeLineView addActionWithBlock:^(id target) {
        @strongify(self);
        checkAndRemove();
        [ShareUtil shareWithImages:self.images type:CLShareWechat completed:^{
            [self cancel:nil];
        }];
    }];
    [self.qqView addActionWithBlock:^(id target) {
        @strongify(self);
        checkAndRemove();
        [ShareUtil shareWithImages:self.images type:CLShareQQ completed:^{
            [self cancel:nil];
        }];
    }];
    [self.qZoneView addActionWithBlock:^(id target) {
        @strongify(self);
        checkAndRemove();
        [ShareUtil shareWithImages:self.images type:CLShareQQ completed:^{
            [self cancel:nil];
        }];
    }];
}
+ (CTSharePopupView *)showSharePopupWithImages:(NSArray <UIImage *>*)images onView:(UIView *)view{
    return [self showSharePopupWithImages:images onView:view contentInset:UIEdgeInsetsZero];
}
+ (CTSharePopupView *)showSharePopupWithImages:(NSArray <UIImage *>*)images onView:(UIView *)view contentInset:(UIEdgeInsets)contentInset{
    if(!view){
        view = [UIApplication sharedApplication].keyWindow;
    }
    CTSharePopupView *popupView = NSMainBundleClass(CTSharePopupView.class);
    popupView.images = images;
    [view addSubview:popupView];
    [popupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(contentInset);
    }];
    popupView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        popupView.alpha = 1.0;
    }];
    return popupView;
}


- (void)setImages:(NSArray<UIImage *> *)images{
    _images = images;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadView];
    });
}
- (void)reloadView{

    [_scrollView removeAllSubViews];
    UIView *containerView = [UIView new];
    [_scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.height.mas_equalTo(_scrollView.mas_height);
    }];
    UIView *leftView;
    for(int i = 0;i < _images.count;i ++){
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = _images[i];
        [containerView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if(leftView){
                make.left.mas_equalTo(leftView.mas_right);
            }
            else{
                make.left.mas_equalTo(0);
            }
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(_scrollView.mas_width);
            if(i == _images.count - 1){
                make.right.mas_equalTo(0);
            }
        }];
        leftView = imageView;
    }

}
- (IBAction)cancel:(id)sender {
    [self removeFromSuperview];
}

@end
