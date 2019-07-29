//
//  CTNetworkEngine+Common.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/4/10.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTNetworkEngine.h"

@interface CTAppFunctionIo:NSObject
@property (nonatomic, assign) BOOL recom_show;
@property (nonatomic, assign) BOOL showRanking;
@property (nonatomic, assign) BOOL app_user_center_show;
@property (nonatomic, assign) BOOL app_start_banner_io;
@property (nonatomic, assign) BOOL app_sale_rank_io;
@property (nonatomic, assign) BOOL app_buying_whole_point_io;
@property (nonatomic, copy) NSString *app_start_banner_img;
@property (nonatomic, copy) NSString *app_ios_version;
@property (nonatomic, copy) NSString *app_ios_url;
@end

@interface CTNetworkEngine (Common)
//会员中心隐藏开关
- (void)iosFunctionIo;
//app功能开关
- (void)appFunctionIo;
@end
