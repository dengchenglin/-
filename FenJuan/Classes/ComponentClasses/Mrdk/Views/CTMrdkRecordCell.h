//
//  CTMrdkRecordCell.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/5.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJMrdkRecordModelfj.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTMrdkRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) FJMrdkRecordModelfj *model;
@end

NS_ASSUME_NONNULL_END
