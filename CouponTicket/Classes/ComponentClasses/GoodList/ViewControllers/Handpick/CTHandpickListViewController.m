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

@interface CTHandpickListViewController ()

@end

@implementation CTHandpickListViewController

- (void)setUpUI{
    [self.tableView registerNibWithClass:CTHandpickListCell.class];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = CTBackGroundGrayColor;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTHandpickListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTHandpickListCell.class)];
    dispatch_async(dispatch_get_main_queue(), ^{
        cell.photoViews.imgs = @[@"",@"",@""];
    });
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CTHandpickDetailViewController *vc = [[CTHandpickDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
