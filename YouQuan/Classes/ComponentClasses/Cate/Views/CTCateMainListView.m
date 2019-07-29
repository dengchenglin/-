//
//  CTCateMainListView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTCateMainListView.h"

@interface CTCateMainItem: UIView

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, assign) BOOL selected;

@end

@implementation CTCateMainItem

ViewInstance(setup)

- (void)setup{
    _textLabel = [[UILabel alloc]init];
    _textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    _textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.numberOfLines = 0;
    [self addSubview:_textLabel];
  
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.bottom.mas_equalTo(0);
    }];

}

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    if(_selected){
        _textLabel.textColor = [UIColor colorWithHexString:@"#E64141"];
        self.backgroundColor = [UIColor whiteColor];
    }
    else{
        _textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        self.backgroundColor = [UIColor clearColor];
    }
}

@end

@implementation CTCateMainListView
{
    UIScrollView *_scrollView;
    UIView *_containerView;
    UIImageView*_selectedLine;
}
- (void)setDatas:(NSArray<CTCategoryModel *> *)datas{
    _datas = [datas copy];
    [self reloadView];
}
- (void)reloadView{
    if(!_datas.count){
        [self removeAllSubViews];
        return;
    }
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.alwaysBounceVertical = YES;
        [self addSubview:_scrollView];
        
        _containerView = [UIView new];
        [_scrollView addSubview:_containerView];
        [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_equalTo(0);
            make.width.mas_equalTo(self->_scrollView);
        }];
        _selectedLine = [[UIImageView alloc]init];
        _selectedLine.backgroundColor = [UIColor colorWithHexString:@"#E64141"];
        [_scrollView addSubview:_selectedLine];
        [_selectedLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(3);
            make.height.mas_equalTo(48);
            make.left.mas_equalTo(0);
        }];
    }
    
    
    [_containerView removeAllSubViews];
    UIView *tempView;
    CGFloat height = 50;
    
    for(int i = 0; i < _datas.count;i ++){
        CTCateMainItem *itemView = [[CTCateMainItem alloc]init];
        itemView.tag = 100 + i;
        itemView.textLabel.text = _datas[i].title;
        [_containerView addSubview:itemView];
        if(i == 0){
            itemView.selected = YES;
        }
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            if(tempView){
                make.top.mas_equalTo(tempView.mas_bottom);
            }
            else{
                make.top.mas_equalTo(0);
            }
            if(i == self->_datas.count - 1){
                make.bottom.mas_equalTo(0);
            }
            make.width.mas_equalTo(self->_containerView.mas_width);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(height);
        }];
        tempView = itemView;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemTap:)];
        [itemView addGestureRecognizer:tap];
    }
    [_selectedLine mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo((height - 48)/2);
    }];
    UIView *itemView = [_containerView viewWithTag:100];
    if(itemView){
        [self itemTap:itemView.gestureRecognizers.firstObject];
    }

}

- (void)itemTap:(UITapGestureRecognizer *)tap{
    _currentIndex = tap.view.tag - 100;
    [self reloadViewWithIndex:_currentIndex];
    if(self.indexChangedBlock){
        self.indexChangedBlock(_currentIndex);
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    [self reloadViewWithIndex:_currentIndex];
}

- (void)reloadViewWithIndex:(NSInteger)index{
    for(int i = 0;i < _datas.count;i ++){
        CTCateMainItem *itemView = [_scrollView viewWithTag:100 + i];
        if(i == index){
            itemView.selected = YES;
            if(_scrollView.contentSize.height >= _scrollView.height){
                if(itemView.origin.y >= _scrollView.contentSize.height - _scrollView.height){
                    [_scrollView setContentOffset:CGPointMake(0, _scrollView.contentSize.height - _scrollView.height) animated:YES];
                }
                else{
                    [_scrollView setContentOffset:CGPointMake(0, itemView.origin.y) animated:YES];
                }
            }
        }
        else{
            itemView.selected = NO;
        }
    }
    
    CGFloat height = 50;
    CGFloat top = (height - 48)/2 + index * height;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_selectedLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(top);
        }];
        [UIView animateWithDuration:0.3 animations:^{
            [self layoutIfNeeded];
        }];
    });
}
@end
