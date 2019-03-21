//
//  CTQuestionModel.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/30.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTQuestionModel : NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) BOOL is_deleted;
@property (nonatomic, copy) NSString *create_at;
@end
