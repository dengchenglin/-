//
//  CTSpreeShopListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSpreeShopListViewController.h"

#import "CTGoodListCell.h"

@interface CTSpreeShopListViewController ()


@end

@implementation CTSpreeShopListViewController

- (void)setUpUI{

    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNibWithClass:CTGoodListCell.class];
}

- (void)autoLayout{

    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
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

