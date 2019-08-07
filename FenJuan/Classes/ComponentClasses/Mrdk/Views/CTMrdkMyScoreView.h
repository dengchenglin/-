//
//  CTMrdkMyScoreView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/5.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJMrdkMyScoreFj.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTMrdkMyScoreView : UIView
@property (weak, nonatomic) IBOutlet UILabel *enrollLabel;
@property (weak, nonatomic) IBOutlet UILabel *gainLabel;
@property (weak, nonatomic) IBOutlet UILabel *morningTimesLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (nonatomic, strong) FJMrdkMyScoreFj *model;
@end

NS_ASSUME_NONNULL_END
