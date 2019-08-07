//
//  CTUpgradePopView.h
//  YouQuan
//
//  Created by dengchenglin on 2019/7/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTAlertView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTUpgradePopView : CTAlertView
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

NS_ASSUME_NONNULL_END
