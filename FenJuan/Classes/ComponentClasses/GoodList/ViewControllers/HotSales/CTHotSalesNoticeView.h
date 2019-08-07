//
//  CTHotSalesNoticeView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FJHotGoodsModelfj.h"

@interface CTHotSalesNoticeView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) FJHotGoodsModelfj *model;

@end
