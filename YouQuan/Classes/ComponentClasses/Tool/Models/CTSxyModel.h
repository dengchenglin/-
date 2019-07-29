//
//  CTXsjcModel.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTSxyModel : NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *video_url;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *is_deleted;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *describe;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) BOOL isPlay;
@end

NS_ASSUME_NONNULL_END
