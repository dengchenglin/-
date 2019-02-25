//
//  CTVideoGoodListCell.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTGoodListView_.h"

@interface CTVideoGoodListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIView *goodBackView;

@property (nonatomic, strong) CTGoodListView_ *goodView;

@end
