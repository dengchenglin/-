//
//  CTMainCategoryView.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/20.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTMainCategoryView.h"

#define CTMainCategoryMaxLineCount 4

#define CTMainCategoryMaxRowCount 3

#define CTMainCategoryItemHeight 109

@interface CTMainCategoryView()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation CTMainCategoryView

+ (CGFloat)heightForCategoryCount:(NSInteger)count{
    NSInteger maxCount = CTMainCategoryMaxLineCount * CTMainCategoryMaxRowCount;
    NSInteger accountCount = count>maxCount?maxCount:count;
    NSInteger row = (accountCount + CTMainCategoryMaxLineCount - 1)/CTMainCategoryMaxLineCount;
    CGFloat height = row * CTMainCategoryItemHeight;
    return height;
}

ViewInstance(setUp)

- (void)setUp{
    [self setUpUI];
    [self autoLayout];
    [self setUpEvent];
}
- (void)setUpUI{
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];

}
- (void)autoLayout{
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setUpEvent{

}


- (void)setCategoryModels:(NSArray<CTCategoryModel *> *)categoryModels{
    _categoryModels = [categoryModels copy];
    [_scrollView removeAllSubViews];
    CGFloat lineCount = CTMainCategoryMaxLineCount;
    CGFloat itemHeight = CTMainCategoryItemHeight;
    CGFloat itemWidth = SCREEN_WIDTH/lineCount;
    CGFloat height = [self.class heightForCategoryCount:_categoryModels.count];
    self.contentHeight = height;
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    NSInteger group = (_categoryModels.count + 11)/12;
    UIView *leftContainerView;
    for(int i = 0,k = 0;i < group;i ++){
        UIView *containerView = [UIView new];
        [_scrollView addSubview:containerView];
        
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            if(leftContainerView){
                make.left.mas_equalTo(leftContainerView.mas_right);
            }
            else{
                make.left.mas_equalTo(0);
            }
            if(i == group - 1){
                make.right.mas_equalTo(0);
            }
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(height);
        }];
        leftContainerView = containerView;
        
        NSInteger count = _categoryModels.count - 12 * i;
        for(int j = 0;j < count;j ++,k++){
            CTMainCategoryItem *item = NSMainBundleClass(CTMainCategoryItem.class);
            item.tag = 100 + k;
            item.titleLabel.text = _categoryModels[k].title;
            [item.goodImageView ct_setImageWithImg:_categoryModels[k].img];
            [containerView addSubview:item];
            
            CGFloat left = (j%4) * itemWidth;
            CGFloat top = (j/4) * itemHeight;
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(left);
                make.top.mas_equalTo(top);
                make.width.mas_equalTo(itemWidth);
                make.height.mas_equalTo(itemHeight);
            }];
            
            @weakify(self)
            [item addActionWithBlock:^(UIView *target) {
                @strongify(self)
                if(self.clickItemBlock){
                    self.clickItemBlock(target.tag - 100);
                }
            }];
        }
    }
}

@end
