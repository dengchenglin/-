//
//  CTSxyTextListViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSxyTextListViewController.h"
#import "CTSxyListCell.h"


@interface CTSxyTextListViewController ()
@property (nonatomic, strong) NSMutableArray <CTSxyModel *>*dataSources;
@end

@implementation CTSxyTextListViewController
@synthesize dataSources = _dataSources;
- (void)setUpUI{
   
    self.tableView.backgroundColor = RGBColor(245, 245, 245);
    [self.tableView registerNibWithClass:CTSxyListCell.class];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
}
- (void)autoLayout{
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)request{
    [CTRequest businessSchoolListWithType:_type callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data error:error modelClass:CTSxyModel.class viewModelClass:nil];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTSxyListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CTSxyListCell.class)];
    cell.model = self.dataSources[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager webService]fj_pushWebFromViewController:self htmlString:self.dataSources[indexPath.row].content];
    vc.title = self.dataSources[indexPath.row].title;
}
@end
