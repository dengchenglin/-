//
//  CTMrdkAmountView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJMrdkIndexModel_fj.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTMrdkAmountView : UIView
@property (weak, nonatomic) IBOutlet UILabel *amountDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (nonatomic, strong) FJMrdkIndexModel_fj *model;
@end

NS_ASSUME_NONNULL_END
