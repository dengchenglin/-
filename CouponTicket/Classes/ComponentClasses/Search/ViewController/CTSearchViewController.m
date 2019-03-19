//
//  CTSearchViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSearchViewController.h"

#import "CTSearchBar.h"

#import "CTSearchPreviewView.h"

@interface CTSearchViewController ()

@property (nonatomic, strong) CTSearchBar *searchBar;

@property (nonatomic, strong) CTSearchPreviewView *previewView;

@end

@implementation CTSearchViewController

- (NSString *)historyCachesKey{
    return @"search_history_key";
}

- (NSString *)keyword{
    return self.searchBar.searchTfd.text.wipSpace;
}

- (UITableView *)dataTableView{
    if(!_dataTableView){
        _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - 40)];
    }
    return _dataTableView;
}

- (CTSearchPreviewView *)previewView{
    if(!_previewView){
        _previewView = [[CTSearchPreviewView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - 40)];
    }
    return _previewView;
}

- (CTSearchBar *)searchBar{
    if(!_searchBar){
        _searchBar = NSMainBundleClass(CTSearchBar.class);
    }
    return _searchBar;
}

- (void)willMoveToParentViewController:(UIViewController *)parent{
    [super willMoveToParentViewController:parent];
    if(!parent){
        [self.searchBar endEditing:YES];
    }
}

- (void)setUpUI{
    self.title = @"搜索";
    self.navigationBarStyle = CTNavigationBarWhite;
    [self.view addSubview:self.dataTableView];
    [self.view addSubview:self.previewView];
    [self.view addSubview:self.searchBar];
}

- (void)autoLayout{
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
}


- (void)setUpEvent{
    @weakify(self)
    [self.searchBar setSearchBlock:^(NSString *keyword) {
        @strongify(self)
        [self searchWithKeyword:keyword];
    }];
    [self.searchBar.searchTfd.cl_textSignal subscribeNext:^(NSString *  x) {
        @strongify(self)
        if(x.length){
            self.previewView.hidden = YES;
        }
        else{
            self.previewView.hidden = NO;
        }
    }];
   //点击了历史或热门
    [self.previewView setSelectKeyBlock:^(NSString *key) {
        @strongify(self);
        self.searchBar.searchTfd.text = key;
        [self searchWithKeyword:key];
    }];
    
    //清除历史记录
    [self.previewView setClearHistoryBlock:^{
        @strongify(self)
        [self clearHistorysForKey:[self historyCachesKey]];
        [self reloadHistoryData];
    }];

}

//用户事件触发的搜索需要调用该方法
- (void)searchWithKeyword:(NSString *)keyword{
    [self.view endEditing:YES];
    if(!keyword.length){
        return;
    }
    [self saveKeyword:keyword forkey:[self historyCachesKey]];
    [self searchKeyword:keyword];
}

//搜索 - 子类调用
- (void)searchKeyword:(NSString *)keyword{}

- (void)request{
    //获取热门关键词和历史记录
    [NSTimer scheduledTimerWithTimeInterval:0.1 block:^(NSTimer *timer) {
        self.previewView.hotKeywords = nil;
        self.previewView.historyKeywords = [self histroysForKey:[self historyCachesKey]];
    } repeats:NO];
}

//刷新历史记录
- (void)reloadHistoryData{
    self.previewView.historyKeywords = [self histroysForKey:[self historyCachesKey]];
}

#pragma mark - save history data

- (void)saveKeyword:(NSString *)keyword forkey:(NSString *)key{
    if(!keyword.length || !key.length)return;
    NSMutableArray *array = [NSMutableArray array];
    NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    if(arr){
        [array addObjectsFromArray:arr];
    }
    [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([keyword isEqualToString:obj]){
            [array removeObject:obj];
        }
    }];
    [array insertObject:keyword atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:key];
}


- (NSArray *)histroysForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

- (void)clearHistorysForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:key];
}


@end
