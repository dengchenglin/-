//
//  FileUtil.m
//  GeihuiCould
//
//  Created by dengchenglin on 2018/10/23.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "FileUtil.h"

#import <UIKit/UIKit.h>

#import <objc/runtime.h>

#import "UIUtil.h"

static int UIDocumentInteractionControllerKey;
@implementation FileUtil

+ (void)openFileUrl:(NSURL *)fileUrl{
    if(!fileUrl)return;
    UIViewController *currentVc = [UIUtil getCurrentViewController];
    if(!currentVc)return;
    UIDocumentInteractionController *vc = [UIDocumentInteractionController interactionControllerWithURL:fileUrl];
    objc_setAssociatedObject(currentVc, &UIDocumentInteractionControllerKey, vc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [vc presentOpenInMenuFromRect:currentVc.view.bounds inView:currentVc.view animated:YES];
}

@end
