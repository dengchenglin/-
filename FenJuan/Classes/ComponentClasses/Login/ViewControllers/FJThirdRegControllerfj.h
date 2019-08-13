//
//  CTThirdRegController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/9.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTPageController.h"

#import "CTLoginBaseViewController.h"

@interface FJThirdRegControllerfj : CTPageController
@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
@property (nonatomic, assign) CTEventKind eventKind;

@property (nonatomic, strong) CTUMSocialUserInfoResponse *response;

@end
