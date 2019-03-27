//
//  CTQuestionViewController.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/30.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTQuestionViewController.h"

#import "CTSearchBar.h"

#import "CTQuestionListCell.h"

#import "CTNetworkEngine+Member.h"

@interface CTQuestionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CTSearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray <CTQuestionModel *>*dataSources;

@end

@implementation CTQuestionViewController

@synthesize dataSources = _dataSources;

- (CTSearchBar *)searchBar{
    if(!_searchBar){
        _searchBar = NSMainBundleClass(CTSearchBar.class);
        _searchBar.searchTfd.layer.cornerRadius = 5;
    }
    return _searchBar;
}

- (void)setUpUI{
    self.title = @"常见问题";
     self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchBar];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(CTQuestionListCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(CTQuestionListCell.class)];
}
- (void)autoLayout{
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.left.right.bottom.mas_equalTo(0);
        
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.searchBar setSearchBlock:^(NSString *keyword) {
        @strongify(self)
        [self.view endEditing:YES];
        [self request];
    }];
}

- (void)request{
    [CTRequest oftenProblemWithPage:self.pageIndex size:self.pageSize name:self.searchBar.searchTfd.text callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            [self analysisAndReloadWithData:data error:error modelClass:CTQuestionModel.class viewModelClass:nil];
        }
    }];
}

#pragma  mark - UITableViewDelegate+DataSoure

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTQuestionListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTQuestionListCell.class)];
    cell.model = self.dataSources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager webService]pushWebFromViewController:self htmlString:self.dataSources[indexPath.row].content];
    vc.title = self.dataSources[indexPath.row].name;
}

@end
