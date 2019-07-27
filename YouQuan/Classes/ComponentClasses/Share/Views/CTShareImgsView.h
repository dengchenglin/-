//
//  CTShareImgsView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTShareImgsView : UIView
@property (nonatomic, copy) NSArray <NSString *> *imgs;
@property (nonatomic, copy, readonly) NSArray <UIImage *> *currentImages;
@property (nonatomic, copy, readonly) NSArray <NSString *> *currentImgs;
@property (nonatomic, copy) void(^clickItemBlock)(void);
@end

NS_ASSUME_NONNULL_END
