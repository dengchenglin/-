//
//  UITextField+Helper.m
//  LightMaster
//
//  Created by Dankal on 2018/12/30.
//  Copyright © 2018 Qianmeng. All rights reserved.
//

#import "UITextField+Helper.h"

@implementation UITextField (Helper)

- (RACSignal *)cl_textSignal{
    @weakify(self)
    return [RACSignal combineLatest:@[self.rac_textSignal,RACObserve(self, text)] reduce:^id _Nonnull{
        @strongify(self)
        return self.text;
    }];
}

@end
