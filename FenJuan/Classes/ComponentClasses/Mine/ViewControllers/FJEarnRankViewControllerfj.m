//
//  CTEarnRankViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/13.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJEarnRankViewControllerfj.h"
#import "FJEarnRankCellfj.h"
#import "FJEarnRankIndexViewModelfj.h"

@interface FJEarnRankViewControllerfj ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray <FJEarnRankIndexViewModelfj *> *dataSources;

@end

@implementation FJEarnRankViewControllerfj

@synthesize delegate = _delegate;

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNibWithClass:FJEarnRankCellfj.class];
    }
    return _tableView;
}

- (void)setUpUI{
    self.hideSystemNavBarWhenAppear = YES;
    [self.view addSubview:self.tableView];
}

- (void)autoLayout{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setModels:(NSArray<CTEarnRankIndexModel *> *)models{
    _models = models;
    self.dataSources = [FJEarnRankIndexViewModelfj bindModels:models];
    if(self.isViewLoaded){
        [self reloadView];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadView];
}

- (void)reloadView{
    [LMDataResultView hideDataResultOnView:self.tableView];
    if(_dataSources){
        [self.tableView reloadData];
        if(!_dataSources.count){
            [LMDataResultView showNoDataResultOnView:self.tableView];
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FJEarnRankCellfj *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FJEarnRankCellfj.class)];
    cell.viewModel = self.dataSources[indexPath.row];
    return cell;
}

- (UIScrollView *)nestScrollView {
    return self.tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]){
        [self.delegate scrollViewDidScroll:scrollView];
    }
    
}



@end
