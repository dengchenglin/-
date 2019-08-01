//
//  CTRecListViewController.m
//  YouQuan
//
//  Created by dengchenglin on 2019/8/1.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTRecListViewController.h"
#import "CTDirectUserView.h"
#import "CTRecListCell.h"
@interface CTRecListViewController()
@property (nonatomic, strong) CTDirectUserView *userView;
@end
@implementation CTRecListViewController
- (CTDirectUserView *)userView{
    if(!_userView){
        _userView = NSMainBundleClass(CTDirectUserView.class);
    }
    return _userView;
}
- (void)setUpUI{
    self.title = @"我的团队";
    [self.tableView registerNibWithClass:CTRecListCell.class];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 96;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.userView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTRecListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTRecListCell.class)];
    return cell;
}
@end
