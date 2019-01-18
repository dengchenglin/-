//
//  CLRefreshConfig.h
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CLRefreshHeader.h"

#import "CLRefreshFooter.h"

typedef NS_ENUM(NSUInteger,CLRefreshHeaderType){
    CLRefreshHeaderCurve = 0,
    CLRefreshHeaderCustom = 1000,
};
typedef NS_ENUM(NSUInteger,CLRefreshFooterType){
    CLRefreshFooterCurve = 0,
    CLRefreshFooterCustom = 1000,
};

@interface CLRefreshConfig : NSObject

@property (nonatomic, weak) CLRefreshHeader *header;

@property (nonatomic, weak) CLRefreshFooter *footer;

@property (nonatomic, assign) CLRefreshHeaderType headerType;

@property (nonatomic, assign) CLRefreshFooterType footerType;

@property (nonatomic, assign) CGFloat refreshDistance;

@property (nonatomic, assign) CGFloat loadMoreDistance;


@end
