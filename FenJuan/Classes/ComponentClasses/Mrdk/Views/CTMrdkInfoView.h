//
//  CTMrdkInfoView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTMrdkIndexModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTMrdkInfoView : UIView
@property (weak, nonatomic) IBOutlet UIView *lookMoreButton;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *zzaoIcon;
@property (weak, nonatomic) IBOutlet UILabel *zzaoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *zzaoDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *zjiaIcon;
@property (weak, nonatomic) IBOutlet UILabel *zjiaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *zjiaDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *zjiuIcon;
@property (weak, nonatomic) IBOutlet UILabel *zjiuNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *zjiuDescLabel;
@property (nonatomic, strong) CTMrdkIndexModel *model;
@end

NS_ASSUME_NONNULL_END
