//
//  CTWithdrawHistoryViewController.m
//  YouQuan
//
//  Created by dengchenglin on 2019/8/2.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTWithdrawHistoryViewController.h"
#import "CTCashListCell.h"

#import "CTNetworkEngine+Cash.h"
@interface CTWithdrawHistoryViewController ()
@property (nonatomic, strong) NSMutableArray <CTCashModel *>*dataSources;
@end

@implementation CTWithdrawHistoryViewController
@synthesize dataSources = _dataSources;
- (void)setUpUI{
    self.title = @"提现记录";
    [self.tableView registerNibWithClass:CTCashListCell.class];
}
- (void)request{
    [CTRequest fj_cashLogWithPageIndex:self.pageIndex pageSize:self.pageSize callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data error:error modelClass:CTCashModel.class viewModelClass:nil];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTCashListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTCashListCell.class)];
    cell.model = self.dataSources[indexPath.row];
    return cell;
}
@end
