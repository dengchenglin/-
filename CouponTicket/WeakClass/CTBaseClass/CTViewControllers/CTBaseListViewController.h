//
//  CTBaseListViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

#import "CTTableView.h"

@interface CTBaseListViewController : CTBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) CTTableView *tableView;

@property (nonatomic, assign) NSUInteger pageIndex;

@property (nonatomic, assign) NSUInteger pageSize;

@property (nonatomic, assign) BOOL isLoadMore;

@property (nonatomic, strong) NSMutableArray *dataSoures;

//- (void)analysisAndReloadWithData:(id)data listKey:(NSString *)listKey error:(LMNetError)error modelClass:(Class)modelClass viewModelClass:(Class <LMViewModelProtocol>)viewModelClass;
@end
