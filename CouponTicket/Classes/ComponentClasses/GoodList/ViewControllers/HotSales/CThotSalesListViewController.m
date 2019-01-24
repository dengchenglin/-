//
//  CThotSalesListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CThotSalesListViewController.h"

#import "CTHotSalesNoticeView.h"

#import "CTGoodListCell.h"

@interface CThotSalesListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CTHotSalesNoticeView *noticeView;

@end

@implementation CThotSalesListViewController

- (CTHotSalesNoticeView *)noticeView{
    if(!_noticeView){
        _noticeView = NSMainBundleClass(CTHotSalesNoticeView.class);
    }
    return _noticeView;
}

- (void)setUpUI{
    self.title = @"实时热销榜";
    [self.view addSubview:self.noticeView];
    [self.view addSubview:self.tableView];
    [self.tableView registerNibWithClass:CTGoodListCell.class];
}

- (void)autoLayout{
    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.noticeView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
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
