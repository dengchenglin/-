//
//  LMPageControl.h
//  LightMaster
//
//  Created by dengchenglin on 2018/12/14.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMPageControlInfo :NSObject

@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, assign) CGFloat itemSpacing;

@property (nonatomic, copy) UIImage *elementNormalImage;

@property (nonatomic, copy) UIImage *elementSelectedImage;

@end

@class LMPageControl;

@protocol LMPageControlDelegate <NSObject>

@optional

- (void)pageControl:(LMPageControl *)pageControl didSelectIndex:(NSUInteger)index;

@end

@interface LMPageControl : UIView

@property (nonatomic, copy) void(^configInfo)(LMPageControlInfo *info);

@property (nonatomic, assign) NSUInteger pageNumber;

@property (nonatomic, weak) id<LMPageControlDelegate>delegate;

- (void)scrollToIndex:(NSUInteger)index;

@end
