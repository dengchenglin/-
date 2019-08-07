//
//  CTSxyTypeView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define CTSxyTypeViewHeight ((SCREEN_WIDTH-26)/2 * 0.39 * 2 + 6 + 66)

@interface CTSxyTypeView : UIView
@property (weak, nonatomic) IBOutlet UIView *xsbkView;
@property (weak, nonatomic) IBOutlet UIView *gsjjView;
@property (weak, nonatomic) IBOutlet UIView *jyfxView;
@property (weak, nonatomic) IBOutlet UIView *dnjxView;

@end

NS_ASSUME_NONNULL_END
