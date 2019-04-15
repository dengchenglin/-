//
//  CTVideoShopPageController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTVideoShopPageController.h"

#import "LMSegmentedControl.h"

#import "CTVideoShopListViewController.h"

#import "CTNetworkEngine+Recommend.h"

#import "CTCategoryModel.h"

@interface CTVideoShopPageController ()<LMSegmentedControlDelegate>

@property (nonatomic, strong) LMSegmentedControl *segmentedControl;

@property (nonatomic, copy) NSArray <CTCategoryModel *> *cates;

@end

@implementation CTVideoShopPageController

- (LMSegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        _segmentedControl = [[LMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _segmentedControl.delegate = self;
        _segmentedControl.layer.contents = (__bridge id)[UIImage imageNamed:@"pic_bt_bg"].CGImage;
        _segmentedControl.segmentedControlType = LMSegmentedControlAuto;
        _segmentedControl.selectedLineWidth = 26;
        _segmentedControl.selectedLineHeight = 4;
        _segmentedControl.selectedLineColor = HexColor(@"#FFC726");
        _segmentedControl.titleNormalColor = HexColor(@"#FFCCBE");
        _segmentedControl.titleSelectedColor = [UIColor whiteColor];
    }
    return _segmentedControl;
}
- (void)setUpUI{
    [self.view addSubview:self.segmentedControl];
    self.contentInsets = UIEdgeInsetsMake(40, 0, 0, 0);
}

- (void)autoLayout{
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
}

- (void)request{
    [CTRequest videoBuyCateWithCallback:^(id data, CLRequest *request, CTNetError error) {
        [LMDataResultView hideDataResultOnView:self.view];
        if(!error){
            [self reloadData:data];
        }
        else if (!self.cates){
            [LMDataResultView showNoNetErrorResultOnView:self.view clickRefreshBlock:^{
                [self request];
            }];
        }
    }];
}

- (void)reloadData:(id)data{

    self.cates = [CTCategoryModel yy_modelsWithDatas:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.segmentedControl.titles = [self.cates map:^id(NSInteger index, CTCategoryModel *element) {
            return element.title;
        }];
    });
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0;i < self.cates.count;i ++){
        CTVideoShopListViewController *vc = [[CTVideoShopListViewController alloc]init];
        vc.cateId = self.cates[i].uid;
        [array addObject:vc];
    }
    self.viewControllers = array;
}

- (void)segmentedControl:(LMSegmentedControl *)segmentedControl didSelectedInbdex:(NSUInteger)index{
    [self scrollToIndex:index];
}
- (void)pageController:(CTPageController *)pageController didScrollToIndex:(NSInteger)index{
    [self.segmentedControl scrollToIndex:index];
}

@end
