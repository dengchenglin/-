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
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否退出登录" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        [alert.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
            if(x.integerValue == 1){
                [CTAppManager logout];
                [[CTModuleManager loginService] showLoginFromViewController:self callback:^(BOOL logined) {
                    if(logined){
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                    else{
                        [CTAppManager sharedInstance].mainTab.selectedIndex = 0;
                    }
                }];
            }
        }];
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
            UIViewController *vc = [[CTModuleManager webService] pushWebFromViewController:self url:nil];
            vc.title = @"关于我们";
        }
        break;
        case 2:
        {
            [[SDImageCache sharedImageCache]clearMemory];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMBProgressHudWithTitle:@"清除完成"];
            }];
        }
        break;
        case 3:
        {
            [[CTModuleManager loginService]pushWithdrawSetpsdFromViewController:self mobile:[CTAppManager user].mobile completed:^{
                [self.navigationController popToViewController:self animated:YES];
            }];
        }
        break;
        default:
            break;
    }
}
@end
