//
//  CTMrdkPaySheetView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTMrdkMoneyContainerView.h"

#import "CTPayTypeContainerView.h"

#import "CTNetworkEngine+Mrdk.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMrdkPayInfo:NSObject
@property (nonatomic, assign) CTMrdkPayType payType;
@property (nonatomic, copy) NSString *money;
@end

@interface CTMrdkPaySheetView : UIView
@property (weak, nonatomic) IBOutlet CTMrdkMoneyContainerView *amountTypeView;
@property (weak, nonatomic) IBOutlet CTPayTypeContainerView *payTypeView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

+ (CTMrdkPaySheetView *)showPaySheetViewWithCompleted:(void(^)(CTMrdkPayInfo *info))completed;
+ (void)hiddenPaySheetView;
@end

NS_ASSUME_NONNULL_END
