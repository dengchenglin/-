//
//  CTIvCodeImgView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/6.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTIvCodeImgView.h"
#import "UIView+YYAdd.h"
@implementation CTIvCodeImgView

+ (void)createImagesWithBackgroundImgs:(NSArray <NSString *>*)backgroundImgs ivCodeImg:(NSString *)ivCodeImg ivCode:(NSString *)ivCode completed:(void(^)(NSArray <UIImage *>*images))completed{
    NSMutableArray *array = [NSMutableArray array];
    for(NSString *backgroundImg in backgroundImgs){
        [self createImageWithBackgroundImg:backgroundImg ivCodeImg:ivCodeImg ivCode:ivCode completed:^(UIImage *image) {
            [array addObject:image];
            if(array.count == backgroundImgs.count){
                if(completed){
                    completed(array);
                }
            }
        }];
    }
}

+ (void)createImageWithBackgroundImg:(NSString *)backgroundImg ivCodeImg:(NSString *)ivCodeImg ivCode:(NSString *)ivCode completed:(void(^)(UIImage *image))completed{
    CTIvCodeImgView *imgView = NSMainBundleClass(CTIvCodeImgView.class);
    imgView.ivCodeLabel.text = ivCode;
    UIView *containerView = [UIView new];
    [containerView insertSubview:imgView atIndex:0];
    [[UIApplication sharedApplication].keyWindow insertSubview:containerView atIndex:0];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_WIDTH/0.66);
    }];
    [containerView layoutIfNeeded];
    

    dispatch_group_t group = dispatch_group_create();
    __weak typeof(imgView) weakImgView = imgView;
    dispatch_group_enter(group);
    [imgView.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:backgroundImg] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [imgView.ivCodeImageView sd_setImageWithURL:[NSURL URLWithString:ivCodeImg] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        dispatch_group_leave(group);
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        UIImage *viewImage = [weakImgView snapshotImage];
        if(completed){
            completed(viewImage);
        }
        [containerView removeFromSuperview];
    });
 
}


@end
