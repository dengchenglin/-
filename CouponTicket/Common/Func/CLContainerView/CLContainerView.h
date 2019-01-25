//
//  CLContainerView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSectionConfig:NSObject

@property (nonatomic, assign) CGFloat sectionHeight;

@property (nonatomic, strong) UIView *sectioView;

@property (nonatomic, assign) CGFloat space;

@end

@interface CLContainerView : UIView

- (void)removeAllObjects;

- (void)addConfig:(void(^)(CLSectionConfig *config))config;

@end
