//
//  CTBaseControllerProtocol.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CTBaseControllerProtocol <NSObject>
@optional

- (void)initialize;

- (void)setUpUI;

- (void)autoLayout;

- (void)frameLayout;

- (void)reloadView;

- (void)request;

- (void)bindViewModel;

- (void)setUpEvent;

- (void)reloadData:(id)data;

@end
