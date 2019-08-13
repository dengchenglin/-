//
//  CTMaterialListViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMaterialListViewController.h"
#import "CTOneGoodIndexCell.h"

#import "CTNetworkEngine+ProGood.h"

#import "CTSharePopupView.h"
@interface CTMaterialListViewController ()<CTOneGoodIndexCellDelegate>

@property (nonatomic, strong) NSMutableArray <CTProGoodIndexViewModel *> *dataSources;

@end

@implementation CTMaterialListViewController

@synthesize dataSources = _dataSources;

- (void)setUpUI{
    self.pageSize = 5;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNibWithClass:CTOneGoodIndexCell.class];
}

- (void)autoLayout{
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)request{
    [CTRequest fj_fqMaterialGoodsWithMinId:self.minId callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data listKey:@"list" error:error modelClass:CTGoodsModel.class viewModelClass:CTProGoodIndexViewModel.class];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.dataSources[indexPath.row].onGoodCellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTOneGoodIndexCell  *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTOneGoodIndexCell.class)];
    cell.viewModel = self.dataSources[indexPath.row];
    cell.index = indexPath.row;
    cell.delegate = self;
    return cell;
}


#pragma mark - CTOneGoodIndexCellDelegate
- (void)didShareWithIndex:(NSInteger)index{
    CTOneGoodIndexCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [CTSharePopupView showSharePopupWithImages:cell.picturesView.images onView:nil];
}
@end
