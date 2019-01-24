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

#define CTPasteTextChangeCountKey @"CTPasteTextChangeCountKey"

#import "CTGoodResultViewController.h"

@implementation CTHomePageController (PopWindow)

+ (void)load{
    [self swizzleInstanceMethod:@selector(viewWillAppear:) with:@selector(ct_viewWillAppear:)];
}

- (void)ct_viewWillAppear:(BOOL)animated{
    [self ct_viewWillAppear:animated];
    
    NSInteger lastChangeCount = [[[NSUserDefaults standardUserDefaults] objectForKey:CTPasteTextChangeCountKey] integerValue];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    //如果有重新粘贴 就会弹出
    if(pasteboard.changeCount != lastChangeCount && pasteboard.string.length != 0){
        [CTPasteCheckPopView showPopViewWithText:pasteboard.string callback:^(NSInteger buttonIndex) {
            if(buttonIndex == 1){
                UIViewController *vc = [[CTModuleManager searchService] goodResultViewControllerWithKeyword:pasteboard.string];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
        [[NSUserDefaults standardUserDefaults]setValue:@(pasteboard.changeCount) forKey:CTPasteTextChangeCountKey];
    }

}

@end
