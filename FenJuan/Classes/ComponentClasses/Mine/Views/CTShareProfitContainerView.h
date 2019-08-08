//
//  CTShareProfitContainerView.h
//  YouQuan
//
//  Created by dengchenglin on 2019/7/29.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTShareProfitContainerView : UIView
@property (nonatomic, strong) UILabel *hhyuan;
@property (nonatomic, strong) UIButton *logshah;
@property (nonatomic, strong) NSString *wumento;
@property (nonatomic, assign) NSInteger xibulaya;
@property (nonatomic, copy) NSArray <UIImage *> *images;
@property (nonatomic, assign, readonly) NSInteger currentIndex;
@property (nonatomic, copy, readonly) UIImage *currentImage;
@end

NS_ASSUME_NONNULL_END
