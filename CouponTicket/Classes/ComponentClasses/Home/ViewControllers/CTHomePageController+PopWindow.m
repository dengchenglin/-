//
//  CTHomePageController+PopWindow.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/24.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTHomePageController+PopWindow.h"

#import "NSObject+YYAdd.h"

#import "CTPasteCheckPopView.h"

#import "CTGoodResultViewController.h"

#import "UIPasteboard+Helper.h"

@implementation CTHomePageController (PopWindow)

+ (void)load{
    [self swizzleInstanceMethod:@selector(viewWillAppear:) with:@selector(ct_viewWillAppear:)];
     [self swizzleInstanceMethod:@selector(viewDidLoad) with:@selector(ct_viewDidLoad)];
}


- (void)ct_viewDidLoad{
    [self ct_viewDidLoad];
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIApplicationDidBecomeActiveNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        UIViewController *vc = [UIUtil getCurrentViewController];
        if(self == vc){
          [self checkPasteboard];
        }
    }];
}
- (void)ct_viewWillAppear:(BOOL)animated{
    [self ct_viewWillAppear:animated];
    [self checkPasteboard];
}

- (void)checkPasteboard{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    //如果有重新粘贴 就会弹出
    NSString *pasteString = pasteboard._newestString;
    if(pasteString.length){
        [CTPasteCheckPopView showPopViewWithText:pasteString callback:^(NSInteger buttonIndex) {
            if(buttonIndex == 1){
                UIViewController *vc = [[CTModuleManager searchService] goodResultViewControllerWithKeyword:pasteString];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
    }
}

@end
