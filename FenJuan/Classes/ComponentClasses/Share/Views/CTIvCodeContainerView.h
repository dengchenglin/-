//
//  CTIvCodeContainerView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/6.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTIvCodeContainerView : UIView
@property (nonatomic, copy) NSArray <UIImage *> *images;
@property (nonatomic, assign, readonly) NSInteger currentIndex;
@property (nonatomic, copy, readonly) UIImage *currentImage;

@end

NS_ASSUME_NONNULL_END
