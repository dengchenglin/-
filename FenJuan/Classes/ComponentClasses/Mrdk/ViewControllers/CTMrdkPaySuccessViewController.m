//
//  CTMrdkPaySuccessViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/3.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMrdkPaySuccessViewController.h"

#import "CTMrdkPaySuccessView.h"

@interface CTMrdkPaySuccessViewController ()
@property (nonatomic, strong) CTMrdkPaySuccessView *successView;
@end

@implementation CTMrdkPaySuccessViewController

- (CTMrdkPaySuccessView *)successView{
    if(!_successView){
        _successView = NSMainBundleName(@"CTMrdkPaySuccessView_");
    }
    return _successView;
}

- (void)setUpUI{
    self.title = @"结果页";
    [self.view addSubview:self.successView];
    [self.successView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)reloadView{
    self.successView.timeLabel.text = [NSString stringWithFormat:@"打卡时间: %@~%@",_model.activity.signin_start_time_label,_model.activity.signin_end_time_label];
}
- (void)setUpEvent{
    @weakify(self)
    [self.successView.doneButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
//        POST_NOTIFICATION(CTRefrehMrdkIndexNotification);
    }];
}
@end
