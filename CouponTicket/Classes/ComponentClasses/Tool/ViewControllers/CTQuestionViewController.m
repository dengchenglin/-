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

@interface CTQuestionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CTSearchBar *searchBar;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray <CTQuestionModel *>*dataSoures;

@end

@implementation CTQuestionViewController

- (CTSearchBar *)searchBar{
    if(!_searchBar){
        _searchBar = NSMainBundleClass(CTSearchBar.class);
        _searchBar.searchTfd.layer.cornerRadius = 5;
    }
    return _searchBar;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(CTQuestionListCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(CTQuestionListCell.class)];
    }
    return _tableView;
}

- (void)setUpUI{
    self.title = @"常见问题";
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
}
- (void)autoLayout{
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
        
    }];
}

#pragma  mark - UITableViewDelegate+DataSoure

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;//self.dataSoures.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTQuestionListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTQuestionListCell.class)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager webService]pushWebFromViewController:self htmlString:nil];
    vc.title = @"问题1";
}

@end
