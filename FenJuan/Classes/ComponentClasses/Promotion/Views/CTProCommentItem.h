//
//  CTProCommentItem.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTProCommentItem : UIView
@property (nonatomic, assign) NSInteger nishuocuole;
@property (nonatomic, strong) UIImageView *sharePotifter;
@property (nonatomic, strong) UIButton *hepercf;
@property (nonatomic, strong) UIView *haodade;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cpyButton;

@end

NS_ASSUME_NONNULL_END
