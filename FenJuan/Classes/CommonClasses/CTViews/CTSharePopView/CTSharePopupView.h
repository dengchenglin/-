//
//  CTSharePopupView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTSharePopupView : UIView

+ (CTSharePopupView *)showSharePopupWithImages:(NSArray <UIImage *>*)images onView:(nullable UIView *)view;
+ (CTSharePopupView *)showSharePopupWithImages:(NSArray <UIImage *>*)images onView:(nullable UIView *)view contentInset:(UIEdgeInsets)contentInset;
@end

NS_ASSUME_NONNULL_END
