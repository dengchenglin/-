//
//  CTSetViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/30.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSetViewController.h"

#import "CTSetListCell.h"

#import "CTSetLogoutView.h"

#import "CTAdviseViewController.h"

@interface CTSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CTSetLogoutView *logoutView;

@property (nonatomic, copy) NSArray <NSString *>*datas;

@end

@implementation CTSetViewController

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(CTSetListCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(CTSetListCell.class)];
    }
    return _tableView;
}

- (CTSetLogoutView *)logoutView{
    if(!_logoutView){
        _logoutView = NSMainBundleClass(CTSetLogoutView.class);
    }
    return _logoutView;
}

- (NSArray <NSString *>*)datas{
    if(!_datas){
        _datas = @[@"意见反馈",@"关于我们",@"清除缓存",@"安全设置"];
    }
    return _datas;
}

- (void)setUpUI{
    self.title = @"设置";
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.tableView];
   
}
- (void)autoLayout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

}

- (void)frameLayout{
    self.logoutView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 86);
    self.tableView.tableFooterView = self.logoutView;
}

- (void)setUpEvent{
    @weakify(self)
    [self.logoutView.logoutButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        
    }];
}
#pragma  mark - UITableViewDelegate+DataSoure

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTSetListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTSetListCell.class)];
    cell.titleLabel.text = self.datas[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            CTAdviseViewController *vc = [CTAdviseViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        break;
        case 1:
        {
            
        }
        break;
        case 2:
        {
            
        }
        break;
        default:
            break;
    }
}
@end
