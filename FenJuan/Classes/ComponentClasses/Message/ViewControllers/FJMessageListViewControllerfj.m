//
//  CTMessageListViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJMessageListViewControllerfj.h"

#import "FJMessageListCellfj.h"

@interface FJMessageListViewControllerfj ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray <CTMessageModel *> *dataSources;
@end

@implementation FJMessageListViewControllerfj
@synthesize dataSources = _dataSources;

- (void)setUpUI{
    self.navigationBarStyle = CTNavigationBarWhite;
    self.title = GetMessageStr(_messageType);
    self.tableView.separatorColor = RGBColor(240, 240, 240);
    [self.tableView registerNibWithClass:FJMessageListCellfj.class];
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
    FJMessageListCellfj *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FJMessageListCellfj.class)];
    cell.model = self.dataSources[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CTMessageModel * model =self.dataSources[indexPath.row];
    UIViewController *vc = [[CTModuleManager webService] fj_pushWebFromViewController:self htmlString:model.detail];
    vc.title = model.title;
}

@end
