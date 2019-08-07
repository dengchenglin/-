//
//  CTMrdkMoneyItem.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMrdkMoneyItem.h"
@interface CTMrdkMoneyItem()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
@implementation CTMrdkMoneyItem

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    if(_selected){
        self.backgroundImageView.image = [UIImage imageNamed:@"pic_bt_bg"];
        [self.containerView recursive:^(UIView *subView) {
            if([subView isKindOfClass:UILabel.class]){
                ((UILabel *)subView).textColor = [UIColor whiteColor];
            }
        }];
    }
    else{
        self.backgroundImageView.image = nil;
        
        [self.containerView recursive:^(UIView *subView) {
            if([subView isKindOfClass:UILabel.class]){
                ((UILabel *)subView).textColor = RGBColor(100, 100, 100);
            }
        }];
    }
}

@end
