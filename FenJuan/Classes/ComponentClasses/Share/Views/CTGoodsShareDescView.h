//
//  CTGoodsShareDescView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTShareImgsView.h"
#import "CTGoodsViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTGoodsShareDescView : UIView
@property (nonatomic, assign) NSInteger howmuch;
@property (nonatomic, strong) UIImageView *sharePotifter;
@property (nonatomic, strong) UIButton *closegelaozi;
@property (nonatomic, copy) NSString *numberonen;
@property (weak, nonatomic) IBOutlet UILabel *imgCountLabel;
@property (weak, nonatomic) IBOutlet CTShareImgsView *imgsContainerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tklTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *tklButton;
@property (weak, nonatomic) IBOutlet UIButton *linkButton;
@property (weak, nonatomic) IBOutlet UIButton *ivCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *cpyButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;


@property (nonatomic, strong) CTGoodsViewModel *viewModel;
@property (nonatomic, copy, readonly) NSString *cpyText;
@property (nonatomic, copy, readonly) NSArray <UIImage *> *shareImages;
@end

NS_ASSUME_NONNULL_END
