//
//  CTCashModel.h
//  YouQuan
//
//  Created by dengchenglin on 2019/8/2.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTCashModel : NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *status_txt;
@property (nonatomic, copy) NSString *account_txt;
@end

NS_ASSUME_NONNULL_END
