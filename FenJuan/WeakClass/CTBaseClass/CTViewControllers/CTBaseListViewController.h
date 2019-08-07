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
