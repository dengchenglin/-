//
//  CTGoodsShareViewController.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTGoodsShareViewController : CTBaseViewController
@property (nonatomic, copy) NSString *goodId;
@property (nonatomic, assign) CTShopKind kind;
@property (nonatomic, strong) CTGoodsViewModel *viewModel;
@end

NS_ASSUME_NONNULL_END
