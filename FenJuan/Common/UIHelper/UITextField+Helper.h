//
//  UITextField+Helper.h
//  LightMaster
//
//  Created by Dankal on 2018/12/30.
//  Copyright © 2018 Qianmeng. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Helper)

- (RACSignal *)cl_textSignal;

@end

NS_ASSUME_NONNULL_END
