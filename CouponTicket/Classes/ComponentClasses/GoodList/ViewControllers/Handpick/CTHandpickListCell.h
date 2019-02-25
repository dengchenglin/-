//
//  CTHandpickListCell.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTPhotoView.h"

@interface CTHandpickListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet CTPhotoView *photoViews;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
