//
//  CTBaseViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTNavigationController.h"

#import "CTBaseControllerProtocol.h"

typedef NS_ENUM(NSInteger,CTNavigationBarStyle) {
    CTNavigationBarRed,
    CTNavigationBarWhite
};

@interface CTScrollView:UIScrollView

@end

@interface CTBaseViewController : UIViewController<CTBaseControllerProtocol>

@property (nonatomic, strong, readonly) CTScrollView *scrollView;

@property (nonatomic, strong, readonly) UIView *autoLayoutContainerView;

@property (nonatomic, assign) BOOL hideSystemNavBarWhenAppear;

@property (nonatomic, assign) BOOL scrollViewAvailable;

@property (nonatomic, assign) BOOL scrollViewAllowMultiGes;

@property (nonatomic, assign) BOOL hideNavBarBottomLine;

@property (nonatomic, assign) BOOL showBackItem;

@property (nonatomic, assign) BOOL didAppear;

@property (nonatomic, assign) CTNavigationBarStyle navigationBarStyle;

- (void)setLeftDefaultItem;

- (UIButton *)setRightButtonWithTitle:(NSString *)title  selector:(SEL)selector;

- (UIButton *)setRightButtonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor selector:(SEL)selector;

- (UIButton *)setRightButtonWithImageName:(NSString *)imageName selector:(SEL)selector;

- (UIButton *)setRightButtonWithImageName:(NSString *)imageName size:(CGSize)size selector:(SEL)selector;

- (UIButton *)setRightButtonWithImageName:(NSString *)imageName imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets selector:(SEL)selector;


- (void)back;

@end
