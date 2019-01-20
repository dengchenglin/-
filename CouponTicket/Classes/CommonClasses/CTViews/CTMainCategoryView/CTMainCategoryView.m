//
//  CTMainCategoryView.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/20.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTMainCategoryView.h"

#define CTMainCategoryHeadViewHeight 44

@implementation CTMainCategoryHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    _closeButton.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3 );
}

@end
@implementation CTMainCategoryItem

@end


@interface CTMainCategoryView()

@property (nonatomic, strong) CTMainCategoryHeadView*headView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation CTMainCategoryView

ViewInstance(setUp)

- (void)setUp{
    [self setUpUI];
    [self autoLayout];
    [self setUpEvent];
}
- (void)setUpUI{
    self.clipsToBounds = YES;
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    _headView = NSMainBundleName(CTMainCategoryHeadView.class);
    [self addSubview:_headView];
}
- (void)autoLayout{
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(CTMainCategoryHeadViewHeight);
    }];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(CTMainCategoryHeadViewHeight);
    }];
}

- (void)setUpEvent{
    @weakify(self)
    [self.headView.closeButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [self show];
    }];
}


- (void)show{
    if(!_categoryModels.count)return;
    [UIView animateWithDuration:0.5 animations:^{
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(CTMainCategoryHeadViewHeight);
        }];
        [self layoutIfNeeded];
    }];

}
- (void)hide{
    if(!_categoryModels.count)return;
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(CTMainCategoryHeadViewHeight - self.contentHeight);
    }];
    [self removeFromSuperview];
   
}

- (void)setCategoryModels:(NSArray<CTCategoryModel *> *)categoryModels{
    _categoryModels = [categoryModels copy];
    [_scrollView removeAllSubViews];
    CGFloat lineCount = 4;
    CGFloat itemHeight = 105;
    CGFloat itemWidth = SCREEN_WIDTH/lineCount;
    
    NSInteger count = _categoryModels.count>12?12:_categoryModels.count;
    NSInteger row = (count + lineCount - 1)/lineCount;
    CGFloat height = row * itemHeight;
    self.contentHeight = height;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CTMainCategoryHeadViewHeight + height);
    }];
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
        make.top.mas_equalTo(CTMainCategoryHeadViewHeight - height);
    }];
    [self layoutIfNeeded];
    
    
    NSInteger group = (_categoryModels.count + 11)/12;
    UIView *leftContainerView;
    for(int i = 0;i < group;i ++){
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
        __block UIView *leftItem;
        __block UIView *topItem;
        for(int j = 0;j < count;j ++){
            CTMainCategoryItem *item = NSMainBundleName(CTMainCategoryItem.class);
            [containerView addSubview:item];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                if(leftItem){
                    make.left.mas_equalTo(leftItem.mas_right);
                }
                else{
                    make.left.mas_equalTo(0);
                }
                if(topItem){
                    make.top.mas_equalTo(topItem.mas_bottom);
                }
                else{
                    make.top.mas_equalTo(0);
                }
                if((j + 1)%4 == 0){
                    topItem = item;
                    leftItem = nil;
                }
                else{
                    leftItem = item;
                }
                
                make.width.mas_equalTo(itemWidth);
                make.height.mas_equalTo(itemHeight);
            }];
        }
    }
}

@end
