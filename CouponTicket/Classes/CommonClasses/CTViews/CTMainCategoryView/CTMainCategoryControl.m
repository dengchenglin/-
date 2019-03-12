//
//  CTMainCategoryControl.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/19.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMainCategoryControl.h"

#import "CTMainCategoryHeadView.h"

@interface CTMainCategoryControl()

@end

@implementation CTMainCategoryControl

ViewInstance(setUp)


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
    _segmentedControl.titleNormalColor = HexColor(@"#FFCCBE");
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

}

- (void)setCategoryModels:(NSArray<CTCategoryModel *> *)categoryModels{
    _categoryModels = [categoryModels copy];
    _unfoldButton.hidden = NO;
    self.segmentedControl.titles = [_categoryModels map:^id(NSInteger index, CTCategoryModel * element) {
        return element.title?:@"";
    }];
}



@end
