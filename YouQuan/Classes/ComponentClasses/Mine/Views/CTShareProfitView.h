//
//  CTShareProfitView.h
//  YouQuan
//
//  Created by dengchenglin on 2019/7/29.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTShareProfitView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UIImageView *userheadImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userlevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *attractiveTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *attractiveProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *attractiveBalanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *qrCodeLabel;
@property (nonatomic, strong) CTUser *user;


+ (void)createImagesWithBackgroundImgs:(NSArray <NSString *>*)backgroundImgs ivCodeImg:(NSString *)ivCodeImg ivCode:(NSString *)ivCode user:(CTUser *)user completed:(void(^)(NSArray <UIImage *>*images))completed;
@end

NS_ASSUME_NONNULL_END
