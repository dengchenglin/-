//
//  CLTextField.h
//  LightMaster
//
//  Created by Dankal on 2018/12/30.
//  Copyright © 2018 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLTextField : UITextField

@property (nonatomic, assign) NSUInteger maxCount;

@property (nonatomic, copy) void(^editingBlock)(BOOL Beyond, NSString *selectedText);

@end

NS_ASSUME_NONNULL_END
