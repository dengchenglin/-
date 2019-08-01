//
//  CTIncomeShareModel.h
//  YouQuan
//
//  Created by dengchenglin on 2019/8/1.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTIncomeShareModel : NSObject
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *level_txt;
@property (nonatomic, copy) NSString *iv_code;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *txt1;
@property (nonatomic, copy) NSString *txt2;
@property (nonatomic, copy) NSString *txt3;
@property (nonatomic, copy) NSString *txt4;
@property (nonatomic, copy) NSArray <NSString *> *imgs;
@property (nonatomic, copy) NSString *iv_code_img;
@end

NS_ASSUME_NONNULL_END
