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

#import "CTNetworkEngine+H5Url.h"
#import "CTNetworkEngine+Member.h"

#import "LMPhotoBrower.h"

#import "CTSetHeadView.h"

#import "DKUploadData.h"

@interface CTSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CTSetLogoutView *logoutView;

@property (nonatomic, copy) NSArray <NSString *>*datas;

@property (nonatomic, copy) NSMutableArray <NSString *>*values;

@property (nonatomic, strong) CTSetHeadView *headView;

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

- (CTSetHeadView *)headView{
    if(!_headView){
        _headView = NSMainBundleClass(CTSetHeadView.class);
    }
    return _headView;
}
- (CTSetLogoutView *)logoutView{
    if(!_logoutView){
        _logoutView = NSMainBundleClass(CTSetLogoutView.class);
    }
    return _logoutView;
}

- (NSArray <NSString *>*)datas{
    if(!_datas){
        _datas = @[@"QQ号",@"微信号",@"意见反馈",@"关于我们",@"清除缓存",@"安全设置",@"当前版本"];
    }
    return _datas;
}

- (NSArray<NSString *> *)values{
    if(!_values){
        NSArray *values = @[[CTAppManager user].qq?:@"",[CTAppManager user].wx?:@"",@"",@"",@"",@"", [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]];
        _values = [[NSMutableArray alloc]initWithArray:values];
    }
    return _values;
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
- (void)reloadView{
    [self.headView.headImageView sd_setImageWithURL:[NSURL URLWithString:[CTAppManager user].headimg]];
    
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
    [self.headView addActionWithBlock:^(id target) {
        @strongify(self)
        [LMPhotoBrower showPhotoActionSheetWithMaxCount:1 callback:^(NSArray<LMPhotoImageItem *> *imageItems) {
            [DKUploadData uploadImages:[imageItems map:^id(NSInteger index, LMPhotoImageItem *element) {
                return element.originalImage;
            }]  callback:^(NSArray<NSString *> *imgUrls) {
                [CTRequest userInfoSaveWithInfo:@{@"headimg":imgUrls.firstObject} callback:^(id data, CLRequest *request, CTNetError error) {
                    if(!error){
                        [MBProgressHUD showMBProgressHudWithTitle:@"上传头像成功"];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.headView.headImageView sd_setImageWithURL:[NSURL URLWithString:imgUrls.firstObject]];
                            [CTAppManager user].headimg = imgUrls.firstObject;
                        });
                        
                    }
                }];
            }];
        }];
    }];
}
#pragma  mark - UITableViewDelegate+DataSoure
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTSetListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTSetListCell.class)];
    cell.titleLabel.text = self.datas[indexPath.row];
    cell.valueLabel.text = self.values[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            UIViewController *vc = [[CTModuleManager userInfoService]viewControllerForType:CTUserEditQQ success:^(id value) {
                self.values[0] = value;
                [self.tableView reloadData];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            UIViewController *vc = [[CTModuleManager userInfoService]viewControllerForType:CTUserEditWX success:^(id value) {
                self.values[0] = value;
                [self.tableView reloadData];
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }
        case 2:
        {
            CTAdviseViewController *vc = [CTAdviseViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        break;
        case 3:
        {
            UIViewController *webVc = [[CTModuleManager webService] pushWebFromViewController:self url:CTH5UrlForType(CTH5UrlAbountUs)];
            webVc.title = @"关于我们";
        }
        break;
        case 4:
        {
            [[SDImageCache sharedImageCache]clearMemory];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMBProgressHudWithTitle:@"清除完成"];
            }];
        }
        break;
        case 5:
        {
            [[CTModuleManager loginService]pushWithdrawSetpsdFromViewController:self mobile:[CTAppManager user].phone completed:^{
                [self.navigationController popToViewController:self animated:YES];
            }];
        }
        break;
        case 6:
        {
          
        }
        
            break;
        default:
            break;
    }
}
@end
