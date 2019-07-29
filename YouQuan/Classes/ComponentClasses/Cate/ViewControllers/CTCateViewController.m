//
//  CTCateViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTCateViewController.h"
#import "CTSearchTextfield.h"
#import "CTCateMainListView.h"
#import "CTCateSubListView.h"
#import "CTNetworkEngine+Index.h"
@interface CTCateViewController ()

@property (nonatomic, strong) CTCateMainListView *mainListView;
@property (nonatomic, strong) CTCateSubListView *subListView;
@property (nonatomic, strong) CTSearchTextfield *searchTextField;

@property (nonatomic, copy) NSArray <CTCategoryModel *> *cates;

@end

@implementation CTCateViewController

- (CTSearchTextfield *)searchTextField{
    if(!_searchTextField){
        _searchTextField = [[CTSearchTextfield alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 76, 32)];
        _searchTextField.layer.cornerRadius = 16;
        _searchTextField.clipsToBounds = YES;
        _searchTextField.backgroundColor = [UIColor colorWithHexString:@"#FF9863"];
        _searchTextField.logoColor = [UIColor whiteColor];
        NSMutableAttributedString *attribuedString = [[NSMutableAttributedString alloc]initWithString:@"粘贴宝贝标题，领券购物"];
        [attribuedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, attribuedString.length)];
        _searchTextField.attributedPlaceholder = attribuedString;

    }
    return _searchTextField;
}
- (CTCateMainListView *)mainListView{
    if(!_mainListView){
        _mainListView = [CTCateMainListView new];
        _mainListView.backgroundColor = [UIColor colorWithHexString:@"#F8F9F9"];
    }
    return _mainListView;
}
- (CTCateSubListView *)subListView{
    if(!_subListView){
        _subListView = [CTCateSubListView new];
    }
    return _subListView;
}

- (void)setUpUI{
    self.title = @"分类";
    self.navigationItem.titleView = self.searchTextField;
    [self.view addSubview:self.mainListView];
    [self.view addSubview:self.subListView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!self.cates){
        [self loadData];
    }
}
- (void)autoLayout{
    [self.mainListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(78);
    }];
    [self.subListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainListView.mas_right);
        make.top.right.bottom.mas_equalTo(0);
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.searchTextField setClickSeachBlock:^{
        @strongify(self)
        UIViewController *vc = [[CTModuleManager searchService]rootViewController];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.mainListView setIndexChangedBlock:^(NSInteger index) {
        @strongify(self)
        self.subListView.model = self.cates[index];
    }];
    [self.subListView setIndexChangedBlock:^(NSInteger index) {
        @strongify(self)
        UIViewController *vc = [[CTModuleManager goodListService]goodListViewControllerWithCategoryId:self.subListView.datas[index].uid];
        vc.title = self.subListView.datas[index].title;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}
- (void)loadData{
    [CTRequest cateWithPid:@"" callback:^(id data, CLRequest *request, CTNetError error) {
        [LMDataResultView hideDataResultOnView:self.view];
        if(!error){
            self.cates = [CTCategoryModel yy_modelsWithDatas:data];
    
            self.mainListView.datas = _cates;
        }
        else if (!self.cates){
            [LMDataResultView showNoNetErrorResultOnView:self.view clickRefreshBlock:^{
                [self request];
            }];
        }
    } cachesType:CTNetCachesJust];
}

@end
