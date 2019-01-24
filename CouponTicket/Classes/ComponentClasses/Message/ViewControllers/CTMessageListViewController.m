//
//  CTMessageListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMessageListViewController.h"

#import "CTMessageListCell.h"

@interface CTMessageListViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CTMessageListViewController

- (void)setUpUI{
    self.navigationBarStyle = CTNavigationBarWhite;
    self.title = _messageKind?@"通知消息":@"系统消息";
    self.tableView.separatorColor = RGBColor(240, 240, 240);
    [self.tableView registerNibWithClass:CTMessageListCell.class];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTMessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTMessageListCell.class)];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager webService] pushWebFromViewController:self htmlString:nil];
    vc.title = @"消息详情";
}

@end
