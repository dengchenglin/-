//
//  UIView+Category.h
//  GeihuiDemo
//
//  Created by peikua on 17/3/20.
//  Copyright © 2017年 peikua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

- (void)removeAllSubViews;


@end

@interface UIView (Apply)

- (UIImage *)toImage;

@end

@interface UIView (Frame)

@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.
@property (nonatomic,readonly) CGFloat maxX;
@property (nonatomic,readonly) CGFloat maxY;

@end
