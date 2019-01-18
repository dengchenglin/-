//
//  CLRefreshFactory.m
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "CLRefreshFactory.h"

#import "CLRefreshCurveHeader.h"

#import "CLRefreshCurveFooter.h"

@implementation CLRefreshFactory

+ (CLRefreshHeader *)createHeaderWithType:(CLRefreshHeaderType)type scrollView:(UIScrollView *)scrollView{
    switch (type) {
        case CLRefreshHeaderCurve:
        {
            return [[CLRefreshCurveHeader alloc]initWithScrollView:scrollView];
        }
            break;
        case CLRefreshHeaderCustom:
        {
            return [CLRefreshManager shareInsatnce].config.header;
        }
        default:
            break;
    }
    return nil;
}

+ (CLRefreshFooter *)createFooterWithType:(CLRefreshFooterType)type scrollView:(UIScrollView *)scrollView{
    switch (type) {
        case CLRefreshFooterCurve:
        {
            return [[CLRefreshCurveFooter alloc]initWithScrollView:scrollView];
        }
            break;
        case CLRefreshHeaderCustom:
        {
            return [CLRefreshManager shareInsatnce].config.footer;
        }
        default:
            break;
    }
    return nil;
}

@end
