//
//  CTTabBarModel.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTTabBarModel : NSObject

/**
 * service
 */
@property (nonatomic, copy) NSString *service;
/**
 * vc标题
 */
@property (nonatomic, copy) NSString *title;
/**
 * tabbar图标
 */
@property (nonatomic, copy) NSString *tabbar_normal_image;
/**
 * tabbar选中图标
 */
@property (nonatomic, copy) NSString *tabbar_selected_image;
/**
 * vc参数
 */
@property (nonatomic, strong) id parm;

@end
