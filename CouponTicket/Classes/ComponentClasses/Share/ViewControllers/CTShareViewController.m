//
//  CTShareViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTShareViewController.h"

#import "CTShareView.h"

@interface CTShareViewController ()

@property (nonatomic, strong) CTShareView *shareView;

@end

@implementation CTShareViewController

- (CTShareView *)shareView{
    if(!_shareView){
        _shareView = NSMainBundleName(@"CTShareView_");
    }
    return _shareView;
}

- (void)setUpUI{
    self.title = @"邀请码";
    [self.view addSubview:self.shareView];
}

- (void)autoLayout{
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


@end
