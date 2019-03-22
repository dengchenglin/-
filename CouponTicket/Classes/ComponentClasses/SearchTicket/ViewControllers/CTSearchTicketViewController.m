//
//  CTSearchTicketViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSearchTicketViewController.h"

#import "CTSearchTikcetNavView.h"

#import "CTSearchTikcetPasteView.h"

#import "UIPasteboard+Helper.h"

#import "CTHotCatoryView.h"

#import "CTYourLikedHeadView.h"

#import "CTSearchTicketViewModel.h"

#import "CTGoodListCell.h"

#import "CTNetworkEngine+Member.h"

@interface CTSearchTicketViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CTSearchTikcetNavView *navView;

@property (nonatomic, strong) CTSearchTikcetPasteView *pasteView;

@property (nonatomic, strong) CTHotCatoryView *categoryView;

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) CTSearchTicketViewModel *viewModel;

@end

@implementation CTSearchTicketViewController

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = CTLightGrayColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNibWithClass:CTGoodListCell.class];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
        } 
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (CTSearchTikcetNavView *)navView{
    if(!_navView){
        _navView = NSMainBundleClass(CTSearchTikcetNavView.class);
    }
    return _navView;
}

- (CTSearchTikcetPasteView *)pasteView{
    if(!_pasteView){
        _pasteView = NSMainBundleClass(CTSearchTikcetPasteView.class);
    }
    return _pasteView;
}

- (CTHotCatoryView *)categoryView{
    if(!_categoryView){
        _categoryView = NSMainBundleClass(CTHotCatoryView.class);
    }
    return _categoryView;
}

- (UIView *)headView{
    if(!_headView){
        _headView = [UIView new];
        [_headView addSubview:self.pasteView];
        [_headView addSubview:self.categoryView];
        
        CTYourLikedHeadView *yourLikedView = NSMainBundleClass(CTYourLikedHeadView.class);
        [_headView addSubview:yourLikedView];
        
        [self.pasteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
        [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.pasteView.mas_bottom);
            make.left.right.mas_equalTo(0);
        }];
        [yourLikedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.categoryView.mas_bottom);
            make.height.mas_equalTo(44);
            make.left.right.bottom.mas_equalTo(0);
        }];
        
    }
    return _headView;
}

- (CTSearchTicketViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [CTSearchTicketViewModel new];
    }
    return _viewModel;
}

- (void)setUpUI{
    self.hideSystemNavBarWhenAppear = YES;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = RGBColor(245, 245, 245);
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)autoLayout{
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(0);
        make.height.mas_equalTo(NAVBAR_HEIGHT + 40);
    }];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom).offset(-30);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_HEIGHT - NAVBAR_HEIGHT - 10 - TABBAR_HEIGHT);
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.pasteView setSearchBlock:^(NSString *keyword) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager searchService] goodResultViewControllerWithKeyword:keyword];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.categoryView.categoryView setClickItemBlock:^(NSInteger index) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager goodListService]goodListViewControllerWithCategoryId:self.viewModel.categoryModels[index].uid];
        vc.title = self.viewModel.categoryModels[index].title;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    
    
    //需要检测粘贴板
    [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIApplicationDidBecomeActiveNotification object:nil]takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        [self checkPasteboard];
    }];
    //登录/退出
    [[[[[NSNotificationCenter defaultCenter]rac_addObserverForName:CTDidLoginNotification object:nil]takeUntil:self.rac_willDeallocSignal] merge:[[[NSNotificationCenter defaultCenter]rac_addObserverForName:CTDidLogoutNotification object:nil]takeUntil:self.rac_willDeallocSignal]] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
        [self request];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkPasteboard];
}
//检测粘贴板
- (void)checkPasteboard{
    NSString *pasteText = [UIPasteboard generalPasteboard]._newestString;
    if(pasteText)
    {
        self.pasteView.text = pasteText;
    }
}

- (void)request{
    [CTRequest hotGoodsCateWithCallback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            [self reloadData:data];
        }
    }];
}

- (void)reloadData:(id)data{
    NSArray <CTCategoryModel *>*models = [CTCategoryModel yy_modelsWithDatas:data[@"cate"]];
    self.viewModel.categoryModels = models;
    self.viewModel.likes = [CTGoodsViewModel bindModels:[CTGoodsModel yy_modelsWithDatas:data[@"list"]]];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   self.categoryView.categoryModels = self.viewModel.categoryModels;
    CGFloat height = [self.headView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, CGFLOAT_MAX)].height;
    return height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.likes.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTGoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTGoodListCell.class)];
    cell.viewModel = self.viewModel.likes[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService]goodDetailViewControllerWithGoodViewModel:self.viewModel.likes[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
