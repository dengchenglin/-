//
//  UIScrollView+CLRefresh.m
//  CLRefreshDemo
//
//  Created by dengchenglin on 2018/9/1.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "UIScrollView+CLRefresh.h"

#import "CLRefreshFactory.h"

#import "CLRefreshManager.h"

#import <objc/runtime.h>

@interface UIScrollView ()

@property (nonatomic, strong)CLRefreshHeader *header;

@property (nonatomic, strong)CLRefreshFooter *footer;

@end

@implementation UIScrollView (CLRefresh)

static int CLRefreshHeaderKey;
static int CLRefreshFooterKey;

- (void)setHeader:(CLRefreshHeader *)header {

    objc_setAssociatedObject(self, &CLRefreshHeaderKey,
                             header,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (CLRefreshHeader *)header {
    return objc_getAssociatedObject(self, &CLRefreshHeaderKey);
}

- (void)setFooter:(CLRefreshFooter *)footer {

    objc_setAssociatedObject(self, &CLRefreshFooterKey,
                             footer,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (CLRefreshFooter *)footer {
    return objc_getAssociatedObject(self, &CLRefreshFooterKey);
}


- (CLRefreshHeader *)addHeaderRefreshWithCallBack:(void(^)(void))callBack{
    if(!self.header){
        CLRefreshHeader *header = [CLRefreshManager createHeaderWithScrollView:self];
        self.header = header;
    }
    self.header.refreshBlock = callBack;
    return self.header;
}

- (CLRefreshFooter *)addFooterRefreshWithCallBack:(void(^)(void))callBack{
    if(!self.footer){
        CLRefreshFooter *footer = [CLRefreshManager createFooterWithScrollView:self];
        self.footer = footer;
    }
    self.footer.refreshBlock = callBack;
    return self.footer;
}

- (void)beginRefreshing{
    if(self.header){
        [self.header beginRefreshing];
    }
}

- (void)endRefreshing{
    if(self.header)[self.header endRefreshing];
    if(self.footer)[self.footer endRefreshing];
}

- (void)showNulMoreView{
   
    if(self.footer)[self.footer showNulMoreView];
}

- (void)hiddenNulMoreView{
    if(self.footer)[self.footer hiddenNulMoreView];
}
@end
