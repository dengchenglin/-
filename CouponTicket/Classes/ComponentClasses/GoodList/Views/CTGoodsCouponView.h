//
//  CTGoodsCouponView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTGoodsViewModel.h"
@interface CTGoodsCouponView : UIView
@property (weak, nonatomic) IBOutlet UILabel *couonTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *couponTimeLabel;
@property (nonatomic, strong) CTGoodsViewModel *viewModel;
@end
