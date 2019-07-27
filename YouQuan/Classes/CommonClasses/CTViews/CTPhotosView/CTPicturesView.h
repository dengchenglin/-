//
//  CTPicturesView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTPictureModel:NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *price;
@end

NS_ASSUME_NONNULL_BEGIN

@interface CTPicturesView : UIView

@property (nonatomic, copy) NSArray <CTPictureModel *>*models;
@property (nonatomic, copy) NSArray <UIImage *> *images;

@property (nonatomic, assign) NSUInteger rowCount;

@property (nonatomic, assign) NSUInteger itemSpace;

@property (nonatomic, assign) NSUInteger lineSpace;

@property (nonatomic, assign) UIEdgeInsets insets;

@property (nonatomic, copy) void(^imageCountDidChangedBlock) (NSInteger count);

@property (nonatomic, copy) void(^clickItemBlock)(NSInteger index);

+ (CGFloat)heightForItemCount:(NSInteger)count row:(NSInteger)row width:(CGFloat)width lineSpace:(CGFloat)lineSpace itemSpace:(CGFloat)itemSpace insets:(UIEdgeInsets)insets;


@end

NS_ASSUME_NONNULL_END
