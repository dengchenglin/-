//
//  CTShareImgsView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTShareImgsView.h"
#import "CTShareImgsItem.h"

@interface CTShareImgsView()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contanierView;

@end
@implementation CTShareImgsView
ViewInstance(setUp)
- (void)setUp{
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    _contanierView = [UIView new];
    [_scrollView addSubview:_contanierView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        
    }];
    [_contanierView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.height.mas_equalTo(self.scrollView.mas_height);
    }];
}

- (void)setImgs:(NSArray<NSString *> *)imgs{
    _imgs = [imgs copy];
    [self reloadView];
}

- (void)reloadView{
    [self.contanierView removeAllSubViews];
    CGFloat itemWidth = 105;
    UIView *leftItem;
    for(int i = 0;i < _imgs.count;i ++){
        CTShareImgsItem *item = NSMainBundleClass(CTShareImgsItem.class);
        [item.imageView sd_setImageWithURL:[NSURL URLWithString:_imgs[i]]];
        item.tag = 100 + i;
       
        [_contanierView addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if(leftItem){
                make.left.mas_equalTo(leftItem.mas_right).offset(8);
            }
            else{
                make.left.mas_equalTo(8);
            }
            make.width.height.mas_equalTo(itemWidth);
            make.top.mas_equalTo(0);
            if(i == _imgs.count - 1){
                make.right.mas_equalTo(0);
            }
        }];
        leftItem = item;
        
 
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAction:)];
        [item addGestureRecognizer:tap];
        if(i == 0){
            __weak typeof(self) weakSelf = self;
            [item.imageView sd_setImageWithURL:[NSURL URLWithString:_imgs[i]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                [weakSelf selectAction:tap];
            }];
        }
    }
}

- (void)selectAction:(UITapGestureRecognizer *)tap{
    CTShareImgsItem *item = (CTShareImgsItem *)tap.view;
    if(!item.selectButton.selected && !item.imageView.image){
        [MBProgressHUD showMBProgressHudWithTitle:@"图片选择失败"];
        return;
    }
    item.selectButton.selected = !item.selectButton.selected;
    if(self.clickItemBlock){
        self.clickItemBlock();
    }
}

- (NSArray<UIImage *> *)currentImages{
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0;i < _imgs.count;i ++){
        CTShareImgsItem *item = [_contanierView viewWithTag:100 + i];
        if(item.selectButton.selected && item.imageView.image){
            [array addObject:item.imageView.image];
        }
    }
    return [array copy];
}
- (NSArray<NSString *> *)currentImgs{
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0;i < _imgs.count;i ++){
        CTShareImgsItem *item = [_contanierView viewWithTag:100 + i];
        if(item.selectButton.selected && item.imageView.image){
            [array addObject:_imgs[i]];
        }
    }
    return [array copy];
}
@end
