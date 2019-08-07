//
//  CTJdpIndexModel.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface CTJdpIndexModel : NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *tb_brand_name;
@property (nonatomic, copy) NSString *fq_brand_name;
@property (nonatomic, copy) NSString *brand_logo;
@property (nonatomic, copy) NSString *brandcat;
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, strong) NSArray <CTGoodsModel *> *item;
@end

NS_ASSUME_NONNULL_END
