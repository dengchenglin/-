//
//  CTOrderListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/14.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTOrderListViewController.h"

#import "CTOrderListCell.h"

#import "CTOrderViewModel.h"

@interface CTOrderListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <CTOrderViewModel *>*dataSources;

@end

@implementation CTOrderListViewController

@synthesize dataSources = _dataSources;

- (void)setUpUI{
    self.hideNavBarBottomLine = YES;
    self.navigationBarStyle = CTNavigationBarWhite;
    self.tableView.backgroundColor = RGBColor(245, 245, 245);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNibWithClass:CTOrderListCell.class];
}
- (void)autoLayout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)request{
    [CTRequest orderIndexWithPage:self.pageIndex size:self.pageSize tkStatus:self.status callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data error:error modelClass:CTOrderModel.class viewModelClass:CTOrderViewModel.class completed:^{
            if(!error){
                if(!self.isLoadMore && self.dataSources.count == 0){
                    [LMNetErrorView showNoOrderResultOnView:self.tableView];
                }
            }
        }];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTOrderListCell.class)];
    cell.viewModel = self.dataSources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *goods_id = self.dataSources[indexPath.row].model.goods_id;
    if([goods_id integerValue]){
        UIViewController *vc = [[CTModuleManager goodListService
          ]goodDetailViewControllerWithGoodId:goods_id];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [MBProgressHUD showMBProgressHudWithTitle:@"商品已失效"];
    }
}
@end
