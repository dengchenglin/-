//
//  CTCashListCell.h
//  YouQuan
//
//  Created by dengchenglin on 2019/8/2.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTCashModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTCashListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) CTCashModel *model;
@end

NS_ASSUME_NONNULL_END
