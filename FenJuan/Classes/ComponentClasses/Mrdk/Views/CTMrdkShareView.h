//
//  CTMrdkShareView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/5.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJMrdkIndexModel_fj.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTMrdkShareView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *acountLabel;
@property (weak, nonatomic) IBOutlet UILabel *phraseLabel;
@property (nonatomic, strong) FJMrdkIndexModel_fj *model;

+ (void)createImageWithModel:(FJMrdkIndexModel_fj *)model completed:(void(^)(UIImage *image))completed;
@end

NS_ASSUME_NONNULL_END
