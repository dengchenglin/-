//
//  LMDataResultView.h
//  LightMaster
//
//  Created by Dankal on 2018/12/22.
//  Copyright © 2018 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMDataResultView : UIView

+ (void)showNoDataResultOnView:(UIView *)view;

+ (void)showNoSearchResultOnView:(UIView *)view;

+ (void)showNoOrderResultOnView:(UIView *)view;

+ (void)showNoDataResultOnView:(UIView *)view frame:(CGRect)frame;

+ (void)showNoNetErrorResultOnView:(UIView *)view clickRefreshBlock:(void(^)(void))clickRefreshBlock;

+ (void)hideDataResultOnView:(UIView *)view;

@end


@interface LMNoDataView:LMDataResultView

@end

@interface LMNetErrorView:LMDataResultView

@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;

@property (nonatomic, copy) void(^clickRefreshBlock)(void);

@end

@interface LMNoQuestionView:LMDataResultView

@end
@interface LMNoResultView: LMDataResultView

@end

@interface LMNoOrderView:LMDataResultView
@end
