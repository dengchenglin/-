//
//  CTVideoShopListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTVideoShopListViewController.h"

#import "CTGoodSortView.h"

#import "CTVideoGoodListCell.h"

@interface CTVideoShopListViewController ()

@property (nonatomic, strong) CTGoodSortView *sortView;

@end

@implementation CTVideoShopListViewController

- (CTGoodSortView *)sortView{
    if(!_sortView){
        _sortView = [[CTGoodSortView alloc]init];
        _sortView.backgroundColor = [UIColor whiteColor];
    }
    return _sortView;
}

- (void)setUpUI{
    [self.view addSubview:self.sortView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNibWithClass:CTVideoGoodListCell.class];
}

- (void)autoLayout{
    [self.sortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sortView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 292;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTVideoGoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTVideoGoodListCell.class)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService] goodDetailViewControllerWithGoodId:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
