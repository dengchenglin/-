//
//  CTMainCategoryControl.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMainCategoryControl.h"

@implementation CTMainCategoryControl

ViewInstance(setUp)

- (CTMainCategoryView *)categoryView{
    if(!_categoryView){
        _categoryView = [[CTMainCategoryView alloc]init];
    }
    return _categoryView;
}

- (void)setUp{
    [self setUpUI];
    [self autoLayout];
    [self setUpEvent];
}

- (void)setUpUI{
    _segmentedControl = [[LMSegmentedControl alloc]init];
    _segmentedControl.backgroundColor = [UIColor clearColor];
    _segmentedControl.segmentedControlType = LMSegmentedControlAuto;
    _segmentedControl.selectedLineWidth = 26;
    _segmentedControl.selectedLineHeight = 4;
    _segmentedControl.selectedLineColor = HexColor(@"#FFC726");
    _segmentedControl.titleNormalColor = RGBColor(200, 200, 200);
    _segmentedControl.titleSelectedColor = [UIColor whiteColor];
    [self addSubview:_segmentedControl];
    
    _unfoldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_unfoldButton setImage:[UIImage imageNamed:@"ic_down_white"] forState:UIControlStateNormal];
    _unfoldButton.hidden = YES;
    [self addSubview:_unfoldButton];
}

- (void)autoLayout{
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(self.unfoldButton.mas_left);
    }];
    [self.unfoldButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(48);
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.unfoldButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [self showAllCategoryView];
    }];
}

- (void)showAllCategoryView{
    if(!self.categoryView.superview){
        UIViewController *vc = [UIUtil getCurrentViewController];
        [vc.view addSubview:self.categoryView];
        [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.right.left.mas_equalTo(0);
            make.height.mas_equalTo(CTMainCategoryHeadViewHeight);
        }];
       //[self.categoryView show];
        
    }
    else{
        [self.categoryView hide];
    }
    
}

- (void)setTitles:(NSArray<NSString *> *)titles{
    _titles = [titles copy];
    self.segmentedControl.titles = _titles;
    _unfoldButton.hidden = NO;
    _categoryView.categoryModels = [_titles map:^id(NSInteger index, id element) {
        CTCategoryModel *model = [CTCategoryModel new];
        model.title = element;
        return model;
    }];
}


@end
