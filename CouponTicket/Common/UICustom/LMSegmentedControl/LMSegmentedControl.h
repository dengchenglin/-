//
//  LMSegmentedControl.h
//  LightMaster
//
//  Created by Dankal on 2018/12/17.
//  Copyright © 2018 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LMSegmentedControlType) {
    LMSegmentedControlScreen,
    LMSegmentedControlAuto,
    LMSegmentedControlConstant
};

typedef NS_ENUM(NSInteger,LMSegmentedControlSilderStyle) {
    LMSegmentedControlSilderLine,
    LMSegmentedControlSilderSquare
};


@class LMSegmentedControl;

@protocol LMSegmentedControlDelegate <NSObject>

- (void)segmentedControl:(LMSegmentedControl *)segmentedControl didSelectedInbdex:(NSUInteger)index;

@end

@interface LMSegmentedControl : UIView

@property (nonatomic, copy) NSArray <NSString *>*titles;

@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, copy) UIColor *titleNormalColor;

@property (nonatomic, copy) UIColor *titleSelectedColor;

@property (nonatomic, copy) UIColor *selectedLineColor;

@property (nonatomic, copy) UIFont *textFont;

@property (nonatomic, assign) CGFloat selectedLineWidth;

@property (nonatomic, assign) CGFloat selectedLineHeight;

@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, weak) id <LMSegmentedControlDelegate>delegate;

@property (nonatomic, assign) LMSegmentedControlType segmentedControlType;

@property (nonatomic, assign) LMSegmentedControlSilderStyle silderStyle;

- (void)scrollToIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
