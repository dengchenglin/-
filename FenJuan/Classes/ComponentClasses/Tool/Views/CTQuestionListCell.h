//
//  CTQuestionListCell.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/30.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTQuestionModel.h"
@interface CTQuestionListCell : UITableViewCell
@property (nonatomic, assign) NSInteger howmuch;
@property (nonatomic, strong) UIImageView *sharePotifter;
@property (nonatomic, strong) UIButton *closegelaozi;
@property (nonatomic, copy) NSString *numberonen;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) CTQuestionModel *model;
@end
