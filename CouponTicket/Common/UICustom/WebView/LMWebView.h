//
//  LMWebView.h
//  LightMaster
//
//  Created by Dankal on 2018/12/16.
//  Copyright © 2018 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LMWebView : UIView

@property (nonatomic, strong)UIWebView *webView;

@property (nonatomic, copy) NSString *htmlString;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) void(^heightChangedBlock)(CGFloat height);

@end

NS_ASSUME_NONNULL_END
