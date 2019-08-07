//
//  CTRecListCell.h
//  YouQuan
//
//  Created by dengchenglin on 2019/8/1.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTRecListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userheadImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLevelLabel;
@property (nonatomic, strong) CTUser *user;
@end

NS_ASSUME_NONNULL_END
