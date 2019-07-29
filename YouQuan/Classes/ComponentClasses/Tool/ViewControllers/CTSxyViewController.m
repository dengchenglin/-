//
//  CTSxyViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSxyViewController.h"
#import "CTSxyTypeView.h"
#import "CTSxyListCell.h"
#import "CTSxySpjxViewController.h"
#import "CTSxyTextListViewController.h"
#import "CTNetworkEngine+Rich.h"

@interface CTSxyViewController ()
@property (nonatomic, strong) CTSxyTypeView *headView;
@property (nonatomic, copy) NSArray <CTSxyModel *> *dataSources;
@end

@implementation CTSxyViewController
@synthesize tableView = _tableView;
- (CTTableView *)tableView{
    if(!_tableView){
        _tableView = [[CTTableView alloc]initWithFrame:CGRectZero  style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBColor(245, 245, 245);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       [_tableView registerNibWithClass:CTSxyListCell.class];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}
- (CTSxyTypeView *)headView{
    if(!_headView){
        _headView = NSMainBundleClass(CTSxyTypeView.class);
    }
    return _headView;
}
- (void)setUpUI{
    self.title = @"商学院";
   
    [self.view addSubview:self.tableView];
}
- (void)autoLayout{
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)request{
    [CTRequest businessSchoolWithCallback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            self.dataSources = [CTSxyModel yy_modelsWithDatas:data[@"list"]];
            [self.tableView reloadData];
        }
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.headView.dnjxView addActionWithBlock:^(id target) {
        @strongify(self)
        CTSxySpjxViewController *vc = [CTSxySpjxViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.headView.gsjjView addActionWithBlock:^(id target) {
        @strongify(self)
        CTSxyTextListViewController *vc = [CTSxyTextListViewController new];
        vc.type = CTSxy_gsjj;
        vc.title = @"高手进阶";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.headView.jyfxView addActionWithBlock:^(id target) {
        @strongify(self)
        CTSxyTextListViewController *vc = [CTSxyTextListViewController new];
        vc.type = CTSxy_jyfx;
        vc.title = @"经验分享";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.headView.xsbkView addActionWithBlock:^(id target) {
        @strongify(self)
        CTSxyTextListViewController *vc = [CTSxyTextListViewController new];
        vc.type = CTSxy_xsbk;
        vc.title = @"新手必看";
        [self.navigationController pushViewController:vc animated:YES];
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CTSxyTypeViewHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTSxyListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTSxyListCell.class)];
    cell.model = self.dataSources[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager webService]pushWebFromViewController:self htmlString:self.dataSources[indexPath.row].content];
    vc.title = self.dataSources[indexPath.row].title;
}
@end
