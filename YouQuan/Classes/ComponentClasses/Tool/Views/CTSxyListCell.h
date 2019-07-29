//
//  CTSxyListCell.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTSxyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTSxyListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic, strong) CTSxyModel *model;
@end

NS_ASSUME_NONNULL_END
