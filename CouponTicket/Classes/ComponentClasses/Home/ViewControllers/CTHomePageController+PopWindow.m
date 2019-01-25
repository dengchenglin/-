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
}

- (void)ct_viewWillAppear:(BOOL)animated{
    [self ct_viewWillAppear:animated];

    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    //如果有重新粘贴 就会弹出
    if(pasteboard._newestString.length){
        [CTPasteCheckPopView showPopViewWithText:pasteboard.string callback:^(NSInteger buttonIndex) {
            if(buttonIndex == 1){
                UIViewController *vc = [[CTModuleManager searchService] goodResultViewControllerWithKeyword:pasteboard._newestString];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
    }

}

@end
