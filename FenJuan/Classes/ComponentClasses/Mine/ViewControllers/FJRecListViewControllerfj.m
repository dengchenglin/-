//
//  CTRecListViewController.m
//  YouQuan
//
//  Created by dengchenglin on 2019/8/1.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJRecListViewControllerfj.h"
#import "FJDirectUserView.h"
#import "CTRecListCell.h"
#import "CTNetworkEngine+Member.h"
#import "CTUserInfoModel.h"
@interface FJRecListViewControllerfj()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FJDirectUserView *userView;
@property (nonatomic, strong) CTUserInfoModel *model;
@end
@implementation FJRecListViewControllerfj

- (FJDirectUserView *)userView{
    if(!_userView){
        _userView = NSMainBundleClass(FJDirectUserView.class);
    }
    return _userView;
}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)setUpUI{
    self.title = @"我的团队";
    self.tableView.backgroundColor = RGBColor(245, 245, 245);
    [self.tableView registerNibWithClass:CTRecListCell.class];
}
- (void)autoLayout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)request{
    self.tableView.hidden = YES;
    [CTRequest fj_teamUserDetailWithUid:_userId callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            self.tableView.hidden = NO;
            self.model = [CTUserInfoModel yy_modelWithDictionary:data];
            self.userView.user = self.model.user;
            self.userView.recCountLabel.text = self.model.people_num;
            [self.tableView reloadData];
        }
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 96;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.userView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.people.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTRecListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTRecListCell.class)];
    cell.user = self.model.people[indexPath.row];
    return cell;
}
@end
