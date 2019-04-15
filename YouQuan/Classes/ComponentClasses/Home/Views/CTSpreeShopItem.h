//
//  CTSpreeShopItem.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTGoodsModel.h"

@interface CTSpreeShopItem : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic, strong) CTGoodsModel *model;

@end
