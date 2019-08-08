//
//  CTSxyTextListViewController.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseListViewController.h"
#import "CTNetworkEngine+Rich.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTSxyTextListViewController : CTBaseListViewController
@property (nonatomic, assign) NSInteger howmuch;
@property (nonatomic, strong) UIImageView *sharePotifter;
@property (nonatomic, strong) UIButton *closegelaozi;
@property (nonatomic, copy) NSString *numberonen;
@property (nonatomic, assign) CTSxyType type;
@end

NS_ASSUME_NONNULL_END
