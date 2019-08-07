//
//  LMPageControl.m
//  LightMaster
//
//  Created by dengchenglin on 2018/12/14.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "LMPageControl.h"
@implementation LMPageControlInfo

@end

@interface LMPageControl ()

@property (nonatomic, strong)LMPageControlInfo *info;

@end

@implementation LMPageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    _info = [LMPageControlInfo new];
    _info.itemSize = CGSizeMake(8, 8);
    _info.itemSpacing = 8;
}

- (void)setConfigInfo:(void (^)(LMPageControlInfo *))configInfo{
    if(configInfo){
       configInfo(_info);
    }
}
- (void)setPageNumber:(NSUInteger)pageNumber{
    _pageNumber = pageNumber;
    [self reloadView];
}


- (void)reloadView{
    [self removeAllSubViews];
    if(_pageNumber < 2)return;
    CGFloat totalWidth = (_info.itemSpacing + _info.itemSize.width) * _pageNumber;
    
    CGFloat left = (self.bounds.size.width - totalWidth)/2 + _info.itemSpacing/2;
    
    CGFloat average = (_info.itemSpacing + _info.itemSize.width);
    for(int i = 0;i < _pageNumber;i ++){
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.tag = 100 + i;
        item.frame = CGRectMake(left + i * average, (self.bounds.size.height - _info.itemSize.height)/2, _info.itemSize.width, _info.itemSize.height);
        [item setImage:_info.elementNormalImage forState:UIControlStateNormal];
        [item setImage:_info.elementSelectedImage forState:UIControlStateSelected];
        [self addSubview:item];
        
        [item addTarget:self action:@selector(itemTap:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [self scrollToIndex:0];
}

- (void)itemTap:(UIButton *)item{
    for(int i = 0;i < _pageNumber;i ++){
        UIButton *button = (UIButton *)[self viewWithTag:100 + i];
        if(button.tag == item.tag){
            button.selected = YES;
        }
        else{
            button.selected = NO;
        }
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(pageControl:didSelectIndex:)]){
        [self.delegate pageControl:self didSelectIndex:item.tag - 100];
    }
}

- (void)scrollToIndex:(NSUInteger)index{
    if(_pageNumber < 2)return;
    for(int i = 0;i < _pageNumber;i ++){
        UIButton *button = (UIButton *)[self viewWithTag:100 + i];
        if((button.tag - 100) == index){
            button.selected = YES;
        }
        else{
            button.selected = NO;
        }
    }
}


@end
