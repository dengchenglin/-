//
//  CTMyCollectListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/31.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMyCollectListViewController.h"

#import "CTGoodListCell.h"

#import "CTNetworkEngine+Member.h"

#import "CTNetworkEngine+Goods.h"

#import "FJGoodsPreViewControllerfj.h"

@interface CTMyCollectListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray <CTGoodsViewModel *> *dataSources;

@end

@implementation CTMyCollectListViewController

@synthesize dataSources = _dataSources;

- (void)setUpUI{
    self.title = @"我的收藏";
    [self.view addSubview:self.tableView];
    [self.tableView registerNibWithClass:CTGoodListCell.class];
}


- (void)autoLayout{
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)request{
    [CTRequest myGoodsFavoriteWithPage:self.pageIndex size:self.pageSize callback:^(id data, CLRequest *request, CTNetError error) {
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

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"取消\n收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        CTGoodsViewModel *viewModel = self.dataSources[indexPath.row];
        [CTRequest favoriteWithGoodsId:viewModel.model.item_id isFavorite:NO callback:^(id data, CLRequest *request, CTNetError error) {
            if(!error){
                [MBProgressHUD showMBProgressHudWithTitle:@"取消成功"];
                [self.dataSources removeObjectAtIndex:indexPath.row];
                [self.tableView reloadData];
                if(!self.dataSources.count){
                    [self request];
                }
            }
        }];
    }];
    action1.backgroundColor = RGBColor(255, 199, 38);
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"分享" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self shareWithGoodsViewModel:self.dataSources[indexPath.row]];
    }];
    action2.backgroundColor = RGBColor(255, 97, 36);
    return @[action1,action2];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService] goodDetailViewControllerWithGoodId:self.dataSources[indexPath.row].model.uid];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)shareWithGoodsViewModel:(CTGoodsViewModel *)viewModel{
    @weakify(self)
    if(![CTAppManager logined]){
        [[CTModuleManager loginService]showLoginFromViewController:self callback:^(BOOL logined) {
            if(logined){
                [self shareWithGoodsViewModel:viewModel];
            }
        }];
        return;
    }

    
   void(^toShare)(id) = ^(id data){
        @strongify(self)
        [FJGoodsPreViewControllerfj pushGoodPreFromViewController:self viewModel:viewModel qCodeContent:data[@"qcode_content"]];
    };
    
    //通过转链接口获取真正的click_url数据
    [AliTradeManager autoWithViewController:self successCallback:^(ALBBSession *session) {
        @strongify(self)
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:viewModel.model.goods_title forKey:@"goods_title"];
        [params setValue:viewModel.model.goods_logo forKey:@"goods_logo"];
        [params setValue:viewModel.model.coupon_share_url forKey:@"coupon_share_url"];
        [CTRequest goodsUrlConvertWithTbGoodsInfo:params callback:^(id data, CLRequest *request, CTNetError error) {
            @strongify(self)
            if(!error){//绑定过渠道id 直接返回最终数据
                if(toShare){
                    toShare(data);
                }
            }
            else{//如果未绑定过渠道id 事先通过淘宝H5授权绑定id同时通过js交互获取真正跳转的数据
                NSInteger status = [data[@"status"] integerValue];
                if(status == 403){
                    NSString *tbAuthUrl = data[@"tbAuth_url"];
                    [[CTModuleManager webService]tbAuthFromViewController:self url:tbAuthUrl callback:^(id data) {
                        if(toShare){
                            toShare(data);
                        }
                    }];
                }
                else{
                    [MBProgressHUD showMBProgressHudWithTitle:data[@"info"]];
                }
            }
        }];
    }];
    

 
}
@end
