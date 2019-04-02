//
//  CLContainerView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CLContainerView.h"
@implementation CLSectionConfig

@end
@interface CLContainerView()<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic, strong) NSMutableArray <CLSectionConfig *>*configs;

@end

@implementation CLContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    _configs = [NSMutableArray array];
    _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_tableView];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    _tableView.backgroundColor = backgroundColor;
}


- (void)removeAllObjects{
    [self.configs removeAllObjects];
    [self.tableView reloadData];
}

- (void)addConfig:(void(^)(CLSectionConfig *config))config{
    CLSectionConfig *cfg = [CLSectionConfig new];
    if(config){
        config(cfg);
        [self.configs addObject:cfg];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.configs.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.configs[section].sectionHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.configs[section].sectioView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return self.configs[section].space?:0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.scrollBlock){
        self.scrollBlock(scrollView.contentOffset);
    }
}
@end
