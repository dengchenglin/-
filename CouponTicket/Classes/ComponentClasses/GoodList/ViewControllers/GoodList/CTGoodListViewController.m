//
//  CTGoodListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodListViewController.h"

#import "CTGoodSortView.h"

#import "CTGoodListCell.h"

@interface CTGoodListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CTGoodSortView *sortView;

@end

@implementation CTGoodListViewController

- (CTGoodSortView *)sortView{
    if(!_sortView){
        _sortView = [[CTGoodSortView alloc]init];
        _sortView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_nav_bg"]];
        _sortView.normalColor = [UIColor whiteColor];
        _sortView.selectedColor = [UIColor whiteColor];
        _sortView.upDownNormalColor = [UIColor whiteColor];
        _sortView.upDownSelectedColor = [UIColor whiteColor];
        _sortView.showSilder = YES;
    }
    return _sortView;
}

- (void)setUpUI{
    [self.view addSubview:self.sortView];
    [self.view addSubview:self.tableView];
    [self.tableView registerNibWithClass:CTGoodListCell.class];
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

- (void)setUpEvent{
    @weakify(self)
    [self.sortView setClickBlock:^(CTGoodSortType type) {
        @strongify(self)
        NSLog(@"%d",type);
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
