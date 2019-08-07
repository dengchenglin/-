//
//  CTMrdkShareView.h
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/5.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTMrdkIndexModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CTMrdkShareView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *acountLabel;
@property (weak, nonatomic) IBOutlet UILabel *phraseLabel;
@property (nonatomic, strong) CTMrdkIndexModel *model;

+ (void)createImageWithModel:(CTMrdkIndexModel *)model completed:(void(^)(UIImage *image))completed;
@end

NS_ASSUME_NONNULL_END
