//
//  CTMemberManager.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,CTMemberLevel) {
    CTMemberStudent = 1,
    CTMemberTeacher,
    CTMemberMatser,
    CTMemberPartner
};

@interface CTMemberManager : NSObject

@end
