//
//  CTHandpickDescView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMWebView.h"
#import "CTGoodsViewModel.h"
@interface FJHandpickDescViewfj : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet LMWebView *webView;
@property (nonatomic, strong) CTGoodsViewModel *viewModel;
@property (nonatomic, copy) void(^heightChangedBlock)(CGFloat height);
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeight;

@end
