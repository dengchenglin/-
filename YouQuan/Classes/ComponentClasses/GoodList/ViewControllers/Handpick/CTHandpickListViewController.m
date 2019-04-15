//
//  CTHandpickListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTHandpickListViewController.h"

#import "CTHandpickListCell.h"

#import "CTHandpickDetailViewController.h"

#import "CTNetworkEngine+Recommend.h"

#import "CTGoodsViewModel.h"

@interface CTHandpickListViewController ()

@property (nonatomic, strong) NSMutableArray <CTGoodsViewModel *> *dataSources;

@end

@implementation CTHandpickListViewController

@synthesize dataSources = _dataSources;

- (void)setUpUI{
    [self.tableView registerNibWithClass:CTHandpickListCell.class];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = CTBackGroundGrayColor;
}

- (void)request{
    [CTRequest officialBuyWithPage:self.pageIndex size:self.pageSize callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data error:error modelClass:CTGoodsModel.class viewModelClass:CTGoodsViewModel.class];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTHandpickListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTHandpickListCell.class)];
    cell.viewModel = self.dataSources[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CTHandpickDetailViewController *vc = [[CTHandpickDetailViewController alloc]init];
    vc.Id = self.dataSources[indexPath.row].model.uid;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
