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
        [_headView addSubview:self.categoryView];
        
        CTYourLikedHeadView *yourLikedView = NSMainBundleClass(CTYourLikedHeadView.class);
        [_headView addSubview:yourLikedView];
        
        [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
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
    [self.view addSubview:self.pasteView];
    [self.view addSubview:self.tableView];
}

- (void)autoLayout{
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(0);
        make.height.mas_equalTo(NAVBAR_HEIGHT + 40);
    }];
    [self.pasteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.navView.mas_bottom).offset(-30);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pasteView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
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
        UIViewController *vc = [[CTModuleManager goodListService]goodListViewControllerWithCategoryId:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    
    //检测粘贴板
    void (^checkPasteBlock)(void) = ^{
        @strongify(self)
        NSString *pasteText = [UIPasteboard generalPasteboard]._newestString;
        if(pasteText)
        {
            self.pasteView.text = pasteText;
        }
    };
    [self aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(BOOL animated){
        checkPasteBlock();
    } error:nil];
    [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIApplicationDidBecomeActiveNotification object:nil]takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        checkPasteBlock();
    }];
}

- (void)request{
    [self reloadData:nil];
}

- (void)reloadData:(id)data{
    NSArray <CTCategoryModel *>*models = [CTCategoryModel yy_modelsWithDatas:[self testCategory]];
    self.viewModel.categoryModels = models;
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
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTGoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTGoodListCell.class)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService]goodDetailViewControllerWithGoodId:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSArray *)testCategory{
    
    return @[@{@"title":@"今日精选"},@{@"title":@"女装"},@{@"title":@"母婴儿童"},@{@"title":@"内衣"},@{@"title":@"居家"},@{@"title":@"男装"},@{@"title":@"女装"},@{@"title":@"内裤"}];
}

@end
