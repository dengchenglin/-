//
//  CTMessageViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJMessageViewControllerfj.h"

#import "FJMessageTypeViewfj.h"

#import "FJMessageListCellfj.h"

#import "FJMessageListViewControllerfj.h"

#import "CTNetworkEngine+Message.h"

#import "CTMessageModel.h"

@interface FJMessageViewControllerfj ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) FJMessageTypeViewfj *typeView;

@property (nonatomic, strong) NSMutableArray <CTMessageModel *> *dataSources;

@end

@implementation FJMessageViewControllerfj

@synthesize dataSources = _dataSources;

- (FJMessageTypeViewfj *)typeView{
    if(!_typeView){
        _typeView = NSMainBundleClass(FJMessageTypeViewfj.class);
    }
    return _typeView;
}

- (void)setUpUI{
    self.title = @"消息中心";
    self.tableView.separatorColor = RGBColor(240, 240, 240);
    [self.tableView registerNibWithClass:FJMessageListCellfj.class];
}

- (void)setUpEvent{
    @weakify(self)
    [self.typeView.systemMessageView addActionWithBlock:^(id target) {
        @strongify(self)
        FJMessageListViewControllerfj *vc = [FJMessageListViewControllerfj new];
        vc.messageType = CTMessageSystem;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [self.typeView.notificationMessageView addActionWithBlock:^(id target) {
        @strongify(self)
        FJMessageListViewControllerfj *vc = [FJMessageListViewControllerfj new];
        vc.messageType = CTMessageNotification;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)request{
    [CTRequest messageIndexWithType:CTMessageAll page:self.pageIndex size:self.pageSize callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data error:error modelClass:CTMessageModel.class viewModelClass:nil];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 145;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.typeView;
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
