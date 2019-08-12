//
//  CTHomeViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

#import "CTPageControllerProtocol.h"

#import "FJHomeViewModelfj.h"

@interface FJHomeViewControllerfj : CTBaseViewController<CTPageControllerProtocol>

@property (nonatomic, strong) FJHomeViewModelfj *viewModel;


@property (nonatomic, strong) NSString *whx;
@property (nonatomic, strong) NSString *wodefuk;
@property (nonatomic, strong) NSString *yapnima;
@end
