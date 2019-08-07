//
//  CTJdpListViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTJdpListViewController.h"
#import "CTJdpDetailViewController.h"

#import "CTJdpListCell.h"

#import "CTNetworkEngine+ThirldTk.h"

@interface CTJdpListViewController ()<CTJdpListCellDelegate>
@property (nonatomic, strong) NSMutableArray <CTJdpIndexModel *> *dataSources;
@end

@implementation CTJdpListViewController
@synthesize dataSources = _dataSources;
- (void)setUpUI{
    [self.tableView registerNibWithClass:CTJdpListCell.class];
    self.tableView.backgroundColor = RGBColor(245, 245, 245);
}
- (void)request{
    [CTRequest hdkJdpWithCateId:self.Id minId:self.minId callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data listKey:@"list" error:error modelClass:CTJdpIndexModel.class viewModelClass:nil];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CTJdpListCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTJdpListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTJdpListCell.class)];
    cell.delegate = self;
    cell.index = indexPath.row;
    cell.model = self.dataSources[indexPath.row];
    return cell;
}

- (void)didClickMoreWithIndex:(NSInteger)index{
    CTJdpDetailViewController *vc = [CTJdpDetailViewController new];
    vc.Id = self.dataSources[index].Id;
    vc.title = self.dataSources[index].fq_brand_name;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didClickItemWithModel:(CTGoodsModel *)model{
    UIViewController *vc = [[CTModuleManager goodListService]goodDetailViewControllerWithGoodId:model.item_id];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
