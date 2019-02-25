//
//  CTHandpickDetailViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHandpickDetailViewController.h"

#import "CTHandpickDescView.h"

#import "CTGoodListCell.h"

@interface CTHandpickDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CTHandpickDescView *descView;

@end

@implementation CTHandpickDetailViewController

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGBColor(245, 245, 245);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNibWithClass:CTGoodListCell.class];

    }
    return _tableView;
}

- (CTHandpickDescView *)descView{
    if(!_descView){
        _descView = NSMainBundleClass(CTHandpickDescView.class);

    }
    return _descView;
}

- (void)setUpUI{
    self.title = @"官方精选";
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.tableView];
}
- (void)autoLayout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setUpEvent{
//    @weakify(self)
//    [self.descView.webView setHeightChangedBlock:^(CGFloat height) {
//        @strongify(self)
//        [self.tableView reloadData];
//    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = [self.descView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.descView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTGoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTGoodListCell.class)];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService] goodDetailViewControllerWithGoodId:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
