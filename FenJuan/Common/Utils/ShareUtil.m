//
//  ShareUtil.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "ShareUtil.h"
#import <Social/Social.h>
NSString * const CLShareWechat = @"com.tencent.xin.sharetimeline";
NSString * const CLShareQQ = @"com.tencent.mqq.ShareExtension";
@implementation ShareUtil
+ (void)shareWithImages:(NSArray <UIImage *>*)images type:(NSString *)type completed:(void(^)(void))completed{
    UIActivityViewController *activity = [[UIActivityViewController alloc]initWithActivityItems:images applicationActivities:nil];
    activity.excludedActivityTypes = [self excludetypes];
    UIViewController *vc = [UIUtil getCurrentViewController];
    [vc presentViewController:activity animated:YES completion:nil];
    activity.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL finish, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if(completed && finish){
            completed();
        }
    };

}
+ (NSArray *)excludetypes{
    
    NSMutableArray *excludeTypesM =  [NSMutableArray arrayWithArray:@[//UIActivityTypePostToFacebook,
                                                                      UIActivityTypePostToTwitter,
                                                                      UIActivityTypePostToWeibo,
                                                                      UIActivityTypeMessage,
                                                                      UIActivityTypeMail,
                                                                      UIActivityTypePrint,
                                                                      UIActivityTypeCopyToPasteboard,
                                                                      UIActivityTypeAssignToContact,
                                                                      UIActivityTypeSaveToCameraRoll,
                                                                      UIActivityTypeAddToReadingList,
                                                                      UIActivityTypePostToFlickr,
                                                                      UIActivityTypePostToVimeo,
                                                                      UIActivityTypePostToTencentWeibo]];
    
    if (@available(iOS 11.0, *)) {
        [excludeTypesM addObject:UIActivityTypeMarkupAsPDF];
    } else {
        
    }
    return excludeTypesM;
}
@end
