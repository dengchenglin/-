//
//  LMDataResultView.m
//  LightMaster
//
//  Created by Dankal on 2018/12/22.
//  Copyright © 2018 Qianmeng. All rights reserved.
//

#import "LMDataResultView.h"

#import <objc/runtime.h>

static const int LMDataResultViewKey;

@implementation LMDataResultView

+ (void)showNoDataResultOnView:(UIView *)view{
    LMNoDataView *resultView = NSMainBundleClass(LMNoDataView.class);
    [self showNoDataResultView:resultView onView:view frame:CGRectZero];
}

+ (void)showNoDataResultOnView:(UIView *)view frame:(CGRect)frame{
    LMNoDataView *resultView = NSMainBundleClass(LMNoDataView.class);
    [self showNoDataResultView:resultView onView:view frame:CGRectZero];
}

+ (void)showNoOrderResultOnView:(UIView *)view{
    LMNoOrderView *resultView = NSMainBundleClass(LMNoOrderView.class);
    [self showNoDataResultView:resultView onView:view frame:CGRectZero];
}

+ (void)showNoSearchResultOnView:(UIView *)view{
    LMNoResultView *resultView = NSMainBundleClass(LMNoResultView.class);
    [self showNoDataResultView:resultView onView:view frame:CGRectZero];
}

+ (void)showNoDataResultView:(LMDataResultView *)resultView onView:(UIView *)view frame:(CGRect)frame{
    if(!view && !view.bounds.size.width)return;
    if(!resultView)return;
    [self hideDataResultOnView:view];
    [view addSubview:resultView];
    [view layoutIfNeeded];
  
    if(CGRectEqualToRect(frame, CGRectZero)){
        [resultView mas_makeConstraints:^(MASConstraintMaker *make) {
            if([view isKindOfClass:[UIScrollView class]]){
                UIScrollView *scrollView = (UIScrollView *)view;
                CGFloat width = scrollView.bounds.size.width - scrollView.contentInset.left - scrollView.contentInset.right;
                CGFloat height = scrollView.bounds.size.height;
                make.edges.mas_equalTo(UIEdgeInsetsZero);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(height);
            }
            else{
                make.edges.mas_equalTo(UIEdgeInsetsZero);
            }
        }];
    }
    else{
        [resultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(frame.origin.x);
            make.left.mas_equalTo(frame.origin.y);
            make.width.mas_equalTo(frame.size.width);
            make.height.mas_equalTo(frame.size.height);
        }];
    }
 
    
    objc_setAssociatedObject(view, &LMDataResultViewKey, resultView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


+ (void)showNoNetErrorResultOnView:(UIView *)view clickRefreshBlock:(void(^)(void))clickRefreshBlock{
    if(!view)return;
    [self hideDataResultOnView:view];
    LMNetErrorView *resultView = NSMainBundleClass(LMNetErrorView.class);
    resultView.clickRefreshBlock = clickRefreshBlock;
    [view addSubview:resultView];
    [resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    
    objc_setAssociatedObject(view, &LMDataResultViewKey, resultView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)hideDataResultOnView:(UIView *)view{
    if(!view)return;
    LMDataResultView *resultView = objc_getAssociatedObject(view, &LMDataResultViewKey);
    if(resultView){
        [resultView removeFromSuperview];
    }
}

@end


@implementation LMNoDataView

@end

@implementation LMNetErrorView

- (void)awakeFromNib{
    [super awakeFromNib];
    _refreshBtn.layer.borderColor = [UIColor colorWithHexString:@"6FBA27"].CGColor;
    _refreshBtn.layer.borderWidth = LINE_WIDTH;
    _refreshBtn.layer.cornerRadius = 2;
    _refreshBtn.clipsToBounds = YES;
}
- (IBAction)refresh:(id)sender {
    if(self.clickRefreshBlock){
        self.clickRefreshBlock();
    }
}

@end

@implementation LMNoQuestionView

@end

@implementation LMNoResultView

@end
@implementation LMNoOrderView
@end
