//
//  CTMrdkMyScoreViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/8/5.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMrdkMyRecordViewController.h"
#import "CTMrdkMyScoreView.h"
#import "CTMrdkRecordCell.h"

#import "CTNetworkEngine+Mrdk.h"

#import "CTMrdkShareView.h"
#import "CTSharePopupView.h"
@interface CTMrdkMyRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) CTTableView *tableView;
@property (nonatomic, strong) CTMrdkMyScoreView *scoreView;
@property (nonatomic, copy) NSArray <FJMrdkRecordModelfj *> *dataSources;
@end

@implementation CTMrdkMyRecordViewController
@synthesize dataSources = _dataSources;

- (CTMrdkMyScoreView *)scoreView{
    if(!_scoreView){
        _scoreView = NSMainBundleClass(CTMrdkMyScoreView.class);
    }
    return _scoreView;
}
- (CTTableView *)tableView{
    if(!_tableView){
        _tableView = [[CTTableView alloc]initWithFrame:CGRectZero  style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBColor(245, 245, 245);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNibWithClass:CTMrdkRecordCell.class];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (void)setUpUI{
    self.title = @"我的战绩";
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"pic_punch_background"].CGImage;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
//    [self.tableView config:^(CLRefreshConfig *config) {
//        config.headTitleColor = [UIColor whiteColor];
//        config.headProgressColor = [UIColor whiteColor];
//    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)setUpEvent{
    @weakify(self)
    [self.tableView addHeaderRefreshWithCallBack:^{
     @strongify(self)
        [self request];
    }];
    [self.scoreView.doneButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [CTMrdkShareView createImageWithModel:self.indexModel completed:^(UIImage * _Nonnull image) {
//            [CTSharePopupView showSharePopupWithImages:@[image] onView:nil completed:nil];
        }];
    }];
}
- (void)request{
    [CTRequest mrdkRecordWithCallback:^(id data, CLRequest *request, CTNetError error) {
        [self.tableView endRefreshing];
        if(!error){
            self.dataSources = [FJMrdkRecordModelfj yy_modelsWithDatas:data[@"list"]];
            self.scoreView.model = [FJMrdkMyScoreFj yy_modelWithDictionary:data[@"my_score"]];
            [self.tableView reloadData];
        }
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 332;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.scoreView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTMrdkRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTMrdkRecordCell.class)];
    cell.model = self.dataSources[indexPath.row];
    return cell;
}
@end
