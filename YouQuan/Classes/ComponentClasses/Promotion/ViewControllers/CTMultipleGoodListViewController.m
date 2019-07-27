//
//  CTMultipleGoodListViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMultipleGoodListViewController.h"

#import "CTNetworkEngine+ProGood.h"

#import "CTProGoodIndexViewModel.h"

#import "CTMultipleGoodsCell.h"

#import "CTMultipleGoodsDetailViewController.h"

#import "CTSharePopupView.h"
@interface CTMultipleGoodListViewController()<CTMultipleGoodsCellDelegate>
@property (nonatomic, strong) NSMutableArray <CTProGoodIndexViewModel*> *dataSources;
@end
@implementation CTMultipleGoodListViewController
@synthesize dataSources = _dataSources;
- (void)setUpUI{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNibWithClass:CTMultipleGoodsCell.class];
    
}
- (void)request{
    [CTRequest fqMultipleGoodsWithMinId:self.minId callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data listKey:@"list" error:error modelClass:CTGoodsModel.class viewModelClass:CTProGoodIndexViewModel.class];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSources[indexPath.row].multipleGoodsCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTMultipleGoodsCell  *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTMultipleGoodsCell.class)];
    cell.viewModel = self.dataSources[indexPath.row];
    cell.index = indexPath.row;
    cell.delegate = self;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CTMultipleGoodsDetailViewController *vc = [CTMultipleGoodsDetailViewController new];
    vc.datas = self.dataSources[indexPath.row].model.item_data;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CTOneGoodIndexCellDelegate
- (void)didShareWithIndex:(NSInteger)index{
  
    CTMultipleGoodsCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    CTGoodsModel *model = self.dataSources[index].model;
    [[CTModuleManager webService]tbAuthFromViewController:self completed:^{
        [MBProgressHUD showMBProgressHudOnView:self.view hideAfterDelay:3.0];
        [[CTModuleManager shareService]createGoodsPreviewWithImages:cell.picturesView.images models:model.item_data completed:^(NSArray<UIImage *> *images) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
               [CTSharePopupView showSharePopupWithImages:images onView:nil];
        }];
    }];
}
- (void)didClickWithModel:(CTGoodsModel *)model{
    UIViewController *vc = [[CTModuleManager goodListService] goodDetailViewControllerWithGoodId:model.item_id];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
