//
//  CLRefreshManager.h
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLRefreshConfig.h"

@interface CLRefreshManager : NSObject

@property (nonatomic, strong) CLRefreshConfig *config;

+ (instancetype)shareInsatnce;

+ (CLRefreshHeader *)createHeaderWithScrollView:(UIScrollView *)scrollView;

+ (CLRefreshFooter *)createFooterWithScrollView:(UIScrollView *)scrollView;

@end
