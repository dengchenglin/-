//
//  CTMineEarnView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/28.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTMyEarnModel.h"
@interface CTMineEarnView : UIView
@property (weak, nonatomic) IBOutlet UILabel *priceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel2;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel3;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel4;
@property (weak, nonatomic) IBOutlet UIButton *earnButton;
@property (weak, nonatomic) IBOutlet UIButton *withdrawButton;
@property (weak, nonatomic) IBOutlet UIButton *earndetailButton;
@property (nonatomic, strong) CTMyEarnModel *model;
@property (nonatomic, strong) CTUser *user;
@end
