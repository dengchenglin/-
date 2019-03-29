//
//  CLRefreshFactory.h
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLRefreshManager.h"

@interface CLRefreshFactory : NSObject

+ (CLRefreshHeader *)createHeaderWithType:(CLRefreshHeaderType)type scrollView:(UIScrollView *)scrollView;

+ (CLRefreshFooter *)createFooterWithType:(CLRefreshFooterType)type scrollView:(UIScrollView *)scrollView;

@end
