//
//  CTMessageListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMessageListViewController.h"

#import "CTMessageListCell.h"

@interface CTMessageListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray <CTMessageModel *> *dataSources;
@end

@implementation CTMessageListViewController
@synthesize dataSources = _dataSources;

- (void)setUpUI{
    self.navigationBarStyle = CTNavigationBarWhite;
    self.title = GetMessageStr(_messageType);
    self.tableView.separatorColor = RGBColor(240, 240, 240);
    [self.tableView registerNibWithClass:CTMessageListCell.class];
}

- (void)request{
    [CTRequest messageIndexWithType:_messageType page:self.pageIndex size:self.pageSize callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data error:error modelClass:CTMessageModel.class viewModelClass:nil];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTMessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTMessageListCell.class)];
    cell.model = self.dataSources[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CTMessageModel * model =self.dataSources[indexPath.row];
    UIViewController *vc = [[CTModuleManager webService] pushWebFromViewController:self htmlString:model.detail];
    vc.title = model.title;
}

@end
