//
//  CTTeamListCell.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CTTeamListCellDelegate <NSObject>
- (void)didClickRecWithIndex:(NSInteger)index;
@end
@interface CTTeamListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userheadImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *userKindLabel;
@property (weak, nonatomic) IBOutlet UIView *recCountView;
@property (weak, nonatomic) IBOutlet UILabel *recCountLabel;
@property (nonatomic, strong) CTUser *user;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<CTTeamListCellDelegate>delegate;
@end
