//
//  CTHomeNavView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJHomeNavViewfj.h"

@interface FJHomeNavViewfj ()

@property (weak, nonatomic) IBOutlet UIButton *item1;
@property (weak, nonatomic) IBOutlet UIButton *item2;
@property (weak, nonatomic) IBOutlet UIButton *item3;
@property (weak, nonatomic) IBOutlet UIButton *item4;
@property (weak, nonatomic) IBOutlet UIButton *item5;

@end

@implementation FJHomeNavViewfj

ViewInstance(setUp)

- (void)setUp{
    for(int i = 0;i < 5;i ++){
        UIButton *item = [self viewWithTag:100 + i];
        @weakify(self)
        [item touchUpInsideSubscribeNext:^(UIButton *x) {
           @strongify(self)
            if(self.activitys && self.clickItemBlock){
                self.clickItemBlock([self.activitys safe_objectAtIndex:x.tag - 100]);
            }
        }];
    }
}

- (void)setActivitys:(NSArray<CTActivityModel *> *)activitys{
    _activitys = [activitys copy];
    [self reloadView];
}

- (void)reloadView{
    for(int i = 0;i < 5;i ++){
        UIButton *item = [self viewWithTag:100 + i];
        CTActivityModel *model = [self.activitys safe_objectAtIndex:i];
        [item sd_setBackgroundImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal];
    }
}

@end
