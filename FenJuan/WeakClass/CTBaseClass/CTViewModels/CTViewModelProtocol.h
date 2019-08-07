//
//  CTViewModelProtocol.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CTViewModelProtocol <NSObject>

@optional

- (void)initialize;

+ (id)bindModel:(id)model;

+ (__kindof NSArray *)bindModels:(NSArray *)models;

@end
