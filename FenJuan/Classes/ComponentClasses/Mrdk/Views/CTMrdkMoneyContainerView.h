//
//  CTMrdkMoneyContainerView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTMrdkIndexModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTMrdkMoneyContainerView : UIView
@property (nonatomic, copy,readonly) NSString *amount;
@property (nonatomic, copy) NSArray<CTMrdkMoneyCate *> *cate;
@end

NS_ASSUME_NONNULL_END
