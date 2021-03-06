//
//  CTShareProfitView.h
//  YouQuan
//
//  Created by dengchenglin on 2019/7/29.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTMyEarnModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTShareProfitView : UIView
@property (nonatomic, assign) NSInteger nishuocuole;
@property (nonatomic, strong) UIImageView *sharePotifter;
@property (nonatomic, strong) UIButton *hepercf;
@property (nonatomic, strong) UIView *haodade;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UIImageView *userheadImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userlevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *attractiveTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *attractiveProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *attractiveBalanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *qrCodeLabel;
@property (nonatomic, copy) NSString *profit;
@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *qrCode;

+ (void)createImagesWithBackgroundImgs:(NSArray <NSString *>*)backgroundImgs ivCodeImg:(NSString *)ivCodeImg ivCode:(NSString *)ivCode earn:(CTMyEarnModel *)earn completed:(void(^)(NSArray <UIImage *>*images))completed;
@end

NS_ASSUME_NONNULL_END
