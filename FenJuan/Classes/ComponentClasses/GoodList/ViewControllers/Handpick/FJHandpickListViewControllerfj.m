//
//  CTHandpickListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJHandpickListViewControllerfj.h"

#import "FJHandpickListCellfj.h"

#import "FJHandpickDetailViewControllerfj.h"

#import "CTNetworkEngine+Recommend.h"

#import "CTGoodsViewModel.h"

@interface FJHandpickListViewControllerfj ()

@property (nonatomic, strong) NSMutableArray <CTGoodsViewModel *> *dataSources;

@end

@implementation FJHandpickListViewControllerfj

@synthesize dataSources = _dataSources;

- (void)setUpUI{
    [self.tableView registerNibWithClass:FJHandpickListCellfj.class];
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
    FJHandpickListCellfj *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FJHandpickListCellfj.class)];
    cell.viewModel = self.dataSources[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FJHandpickDetailViewControllerfj *vc = [[FJHandpickDetailViewControllerfj alloc]init];
    vc.Id = self.dataSources[indexPath.row].model.uid;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
