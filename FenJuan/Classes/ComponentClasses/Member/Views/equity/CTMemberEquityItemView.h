//
//  CTMemberEquityItemView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTMemberRebateModel.h"
@interface CTMemberEquityItemView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) NSArray <CTMemberRebateModel *> *datas;
@property (nonatomic, strong) NSString *hhwhy;
@property (nonatomic, strong) NSString *nimazale;
@property (nonatomic, strong) NSString *commonpp;
@property (nonatomic, assign) NSInteger wodekahao;
@end
