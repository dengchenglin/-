//
//  CTSpreeShopListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSpreeShopListViewController.h"

#import "CTGoodListCell.h"

#import "CTNetworkEngine+Recommend.h"

@interface CTSpreeShopListViewController ()

@property (nonatomic, strong) NSMutableArray <CTGoodsViewModel *> *dataSources;

@end

@implementation CTSpreeShopListViewController

@synthesize dataSources = _dataSources;

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


- (void)request{
    [CTRequest timeBuyGoodsWithPage:self.pageIndex size:self.pageSize markeId:self.model.Id callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data error:error modelClass:CTGoodsModel.class viewModelClass:CTGoodsViewModel.class];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTGoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTGoodListCell.class)];
    cell.viewModel = self.dataSources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CTGoodsModel *model = self.dataSources[indexPath.row].model;
   if (model.status == 1){
        [CTAlertHelper showNoticeAlertViewWithTitle:@"商品已结束!\n请选择其他商品～"];
    }
   else if(model.status == 3){
       [CTAlertHelper showNoticeAlertViewWithTitle:@"商品还未到开抢时间哦!\n请耐心等待商品开抢～"];
      
   }
    else if (model.status == 2){
        UIViewController *vc = [[CTModuleManager goodListService] goodDetailViewControllerWithGoodId:model.uid];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
    

}


@end

