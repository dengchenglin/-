//
//  CTMineBalanceView.h
//  YouQuan
//
//  Created by dengchenglin on 2019/7/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTMineBalanceView : UIView
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *withdrawButton;
@property (weak, nonatomic) IBOutlet UIView *earndetailButton;
@property (nonatomic, strong) CTUser *user;
@end

NS_ASSUME_NONNULL_END
