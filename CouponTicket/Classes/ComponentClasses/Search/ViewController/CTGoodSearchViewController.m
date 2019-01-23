
//
//  CTGoodSearchViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodSearchViewController.h"

#import "CTGoodListCell.h"

@interface CTGoodSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CTGoodSearchViewController

- (void)setUpUI{
    self.dataTableView.delegate = self;
    self.dataTableView.dataSource = self;
    [self.dataTableView registerNibWithClass:CTGoodListCell.class];
}

- (void)searchKeyword:(NSString *)keyword{
    [self.dataTableView reloadData];
}

#pragma mark - UITableViewDelegate

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

@end
