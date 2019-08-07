//
//  CTMrdkMoneyItem.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMrdkMoneyItem : UIView
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) BOOL selected;
@end

NS_ASSUME_NONNULL_END
