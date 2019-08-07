//
//  CTSearchBar.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTSearchTextfield.h"
@interface CTSearchBar : UIView
@property (weak, nonatomic) IBOutlet CTSearchTextfield *searchTfd;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (nonatomic, copy) void(^searchBlock)(NSString *keyword);
@end
