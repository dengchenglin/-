//
//  CTBaseViewController+Debug.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController+Debug.h"

#import "NSObject+YYAdd.h"
#ifdef DEBUG
#import "PLeakSniffer.h"
#endif
@implementation CTBaseViewController (Debug)

+ (void)load{
    [self swizzleInstanceMethod:@selector(viewDidLoad) with:@selector(cl_debug_viewDidLoad)];
}

- (void)cl_debug_viewDidLoad{
    [self cl_debug_viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showApnsToken)];
    tap.numberOfTapsRequired = 8;
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    [self.navigationController.navigationBar addGestureRecognizer:tap];
    
    #ifdef DEBUG
    [self configSniffer];
    [[UIApplication sharedApplication]setApplicationSupportsShakeToEdit:YES];
    #endif
}

- (void)showApnsToken{
    if([CTAppManager sharedInstance].apns_token){
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"apnsToken" message:[CTAppManager sharedInstance].apns_token delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"复制", nil];
        [alt show];
        [alt.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
            if(x.integerValue == 1){
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = [CTAppManager sharedInstance].apns_token;
            }
        }];
    }
}

#ifdef DEBUG
#pragma mark - yaoyiyao

- (void)configSniffer{

    [[PLeakSniffer sharedInstance]installLeakSniffer];

}

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //检测到摇动开始
    if (motion == UIEventSubtypeMotionShake)
    {
        if([CTAppManager sharedInstance].apns_token){
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"apnsToken" message:[CTAppManager sharedInstance].apns_token delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"复制", nil];
            [alt show];
            [alt.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
                if(x.integerValue == 1){
                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                    pasteboard.string = [CTAppManager sharedInstance].apns_token;
                }
            }];
        }
    }
    
}
#endif



@end
