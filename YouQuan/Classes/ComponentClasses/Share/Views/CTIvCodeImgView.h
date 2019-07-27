//
//  CTIvCodeImgView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/6.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTIvCodeImgView : UIView
@property (weak, nonatomic) IBOutlet UILabel *ivCodeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ivCodeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
+ (void)createImagesWithBackgroundImgs:(NSArray <NSString *>*)backgroundImgs ivCodeImg:(NSString *)ivCodeImg ivCode:(NSString *)ivCode completed:(void(^)(NSArray <UIImage *>*images))completed;
@end

NS_ASSUME_NONNULL_END
