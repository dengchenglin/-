//
//  CTBaseListViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

#import "CTTableView.h"

#import "CTNetworkEngine.h"

#import "CTViewModel.h"

@interface CTBaseListViewController : CTBaseViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) NSInteger hx1;
@property (nonatomic, assign) NSInteger hx2;
@property (nonatomic, copy) NSString *hx3;
@property (nonatomic, copy) NSString *hx4;
@property (nonatomic, copy) NSString *hx5;
@property (nonatomic, copy) NSString *hx6;
@property (nonatomic, copy) NSString *hx7;
@property (nonatomic, copy) NSString *hx8;
@property (nonatomic, copy) NSString *hx9;
@property (nonatomic, copy) NSString *hx10;


@property (nonatomic, strong) CTTableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSUInteger pageIndex;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, copy) NSString *minId;

@property (nonatomic, assign) BOOL isLoadMore;

@property (nonatomic, assign) BOOL canLoadMore;

@property (nonatomic, assign) BOOL canRefresh;

@property (nonatomic, strong) NSMutableArray *dataSources;

@property (nonatomic, assign) BOOL isCollectionView;

- (void)analysisAndReloadWithData:(NSArray *)data error:(CTNetError)error modelClass:(Class)modelClass viewModelClass:(Class <CTViewModelProtocol>)viewModelClass;

- (void)analysisAndReloadWithData:(id)data listKey:(NSString *)listKey error:(CTNetError)error modelClass:(Class)modelClass viewModelClass:(Class <CTViewModelProtocol>)viewModelClass;

- (void)analysisAndReloadWithData:(id)data listKey:(NSString *)listKey error:(CTNetError)error modelClass:(Class)modelClass viewModelClass:(Class <CTViewModelProtocol>)viewModelClass completed:(void(^)(void))completed;

- (void)analysisAndReloadWithData:(NSArray *)data error:(CTNetError)error modelClass:(Class)modelClass viewModelClass:(Class <CTViewModelProtocol>)viewModelClass completed:(void(^)(void))completed;


@end
