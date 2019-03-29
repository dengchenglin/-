//
//  UITextView+Helper.m
//  LightMaster
//
//  Created by Dankal on 2019/1/11.
//  Copyright © 2019 Qianmeng. All rights reserved.
//

#import "UITextView+Helper.h"

@implementation UITextView (Helper)

- (RACSignal *)cl_textSignal{
    @weakify(self)
    return [RACSignal combineLatest:@[self.rac_textSignal,RACObserve(self, text)] reduce:^id _Nonnull{
        @strongify(self)
        return self.text;
    }];
}

@end
