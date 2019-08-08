//
//  CTProCommentView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTProGoodIndexViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTProCommentView : UIView
@property (nonatomic, assign) NSInteger nishuocuole;
@property (nonatomic, strong) UIImageView *sharePotifter;
@property (nonatomic, strong) UIButton *hepercf;
@property (nonatomic, strong) UIView *haodade;


@property (nonatomic, copy) NSArray <NSString *>*comments;
@end

NS_ASSUME_NONNULL_END
