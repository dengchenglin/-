//
//  CTJdpPageViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTJdpPageViewController.h"
#import "CTJdpListViewController.h"
#import "LMSegmentedControl.h"

#import "CTNetworkEngine+ThirldTk.h"
@interface CTJdpPageViewController ()<LMSegmentedControlDelegate>
@property (nonatomic, strong) LMSegmentedControl *segmentedControl;
@property (nonatomic, copy) NSArray <CTCategoryModel *> *cates;
@end

@implementation CTJdpPageViewController

- (LMSegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        _segmentedControl = [[LMSegmentedControl alloc]init];
        _segmentedControl.delegate = self;
        _segmentedControl.backgroundImage = [UIImage imageNamed:@"pic_bt_bg"];
        _segmentedControl.segmentedControlType = LMSegmentedControlAuto;
        _segmentedControl.selectedLineWidth = 26;
        _segmentedControl.selectedLineHeight = 2;
        _segmentedControl.selectedLineColor = HexColor(@"#FFC726");
        _segmentedControl.titleNormalColor = HexColor(@"#FFCCBE");
        _segmentedControl.titleSelectedColor = [UIColor whiteColor];
    }
    return _segmentedControl;
}

- (void)setUpUI{
    self.title = @"聚大牌";
    [self.view addSubview:self.segmentedControl];
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    self.contentInsets = UIEdgeInsetsMake(40, 0, 0, 0 );
    
   
}

- (void)request{
    _segmentedControl.hidden = YES;
    [CTRequest hdkJdpWithCateId:nil minId:nil callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            _segmentedControl.hidden = NO;
            self.cates = [CTCategoryModel yy_modelsWithDatas:data[@"cate"]];
            self.segmentedControl.titles = [self.cates map:^id(NSInteger index, CTCategoryModel *element) {
                return element.cate_title;
            }];
            NSMutableArray *array = [NSMutableArray array];
            for(int i = 0;i < self.segmentedControl.titles.count;i ++){
                CTJdpListViewController *vc = [CTJdpListViewController new];
                vc.Id = self.cates[i].uid;
                [array addObject:vc];
            }
            self.viewControllers = array;
        }
    }];
}

- (void)segmentedControl:(LMSegmentedControl *)segmentedControl didSelectedInbdex:(NSUInteger)index{
    [self scrollToIndex:index];
}

- (void)pageController:(CTPageController *)pageController didScrollToIndex:(NSInteger)index{
    [self.segmentedControl scrollToIndex:index];
}
@end
