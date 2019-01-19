//
//  CTTabBarItem.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTTabBarItem : UIView

@property (nonatomic, copy)   UIImage *image;

@property (nonatomic, copy)   UIImage *selectedImage;

@property (nonatomic, copy)   NSString *title;

@property (nonatomic, assign) BOOL selected;

- (void)addTapGestureRecognizerWithBlock:(void(^)(id sender))block;

@end
