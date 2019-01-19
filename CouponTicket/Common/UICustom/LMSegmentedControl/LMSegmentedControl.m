//
//  LMSegmentedControl.m
//  LightMaster
//
//  Created by Dankal on 2018/12/17.
//  Copyright © 2018 Qianmeng. All rights reserved.
//

#import "LMSegmentedControl.h"

#import "CALayer+YYAdd.h"

#define LMSegmentedItemMinWidth 50

@interface LMSegmentedModel:NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) CGFloat width;

@end

@implementation LMSegmentedModel

@end

@interface LMSegmentedControl ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *seletcedLine;

@property (nonatomic, copy) NSArray<LMSegmentedModel*> *models;

@end

@implementation LMSegmentedControl{
    UIView *_containerView;
    UIView *_scrollContainerView;
    CGFloat _itemWidth;
}

ViewInstance(setUp)


- (void)setUp{
    _containerView = [[UIView alloc]init];
    [self addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    _titleNormalColor = [UIColor colorWithHexString:@"#999999"];
    _titleSelectedColor = [UIColor redColor];
    _selectedLineColor = [UIColor redColor];
    _selectedLineWidth = 20;
    _selectedLineHeight = 2;
    _textFont = [UIFont systemFontOfSize:14];
}


- (void)setTitles:(NSArray<NSString *> *)titles{
    _titles = [titles copy];
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:_containerView.bounds];
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
 
        [_containerView addSubview:self.scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];

        _scrollView.contentSize = CGSizeMake(0, _containerView.height);
    }
    [_scrollView removeAllSubViews];
    if(_segmentedControlType == LMSegmentedControlScreen){
        if(!_seletcedLine){
            _seletcedLine = [[UIImageView alloc]init];
          
        }
        _seletcedLine.backgroundColor = _selectedLineColor;
        _seletcedLine.layer.cornerRadius = _selectedLineHeight/2;
        _seletcedLine.clipsToBounds = YES;
        [_containerView addSubview:_seletcedLine];
        _itemWidth = self.width/_titles.count;
        if(_itemWidth < LMSegmentedItemMinWidth){
            _itemWidth = LMSegmentedItemMinWidth;
        }
        for(int i = 0;i < _titles.count;i ++){
            UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            itemBtn.tag = 100 + i;
            [itemBtn setFrame:CGRectMake(_itemWidth * i, 0, _itemWidth, _scrollView.height)];
            [itemBtn setTitle:_titles[i] forState:UIControlStateNormal];
            [itemBtn setTitleColor:_titleNormalColor forState:UIControlStateNormal];
            [itemBtn setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
            itemBtn.titleLabel.font = _textFont;
            [itemBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:itemBtn];
            if(i == _currentIndex){
                itemBtn.selected = YES;
                [_seletcedLine setBounds:CGRectMake(0, 0, _selectedLineWidth, _selectedLineHeight)];
                [_seletcedLine setCenter:CGPointMake(_itemWidth/2 + _itemWidth * _currentIndex, _containerView.height - _seletcedLine.height/2)];
            }
        }
        _scrollView.contentSize = CGSizeMake(_titles.count * (_itemWidth), _scrollView.contentSize.height);
    }
    else if (_segmentedControlType == LMSegmentedControlAuto){
        _scrollContainerView = [UIView new];
        [_scrollView addSubview:_scrollContainerView];
        [_scrollContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
            make.height.mas_equalTo(self->_containerView.height);
        }];
        NSMutableArray <LMSegmentedModel *>*models = [NSMutableArray array];
        CGFloat totalWidth = 0;
        for(int i = 0;i < _titles.count;i ++){
            LMSegmentedModel *model = [LMSegmentedModel new];
            model.title = titles[i];
            model.width = [model.title sizeWithFont:_textFont maxSize:CGSizeMake(CGFLOAT_MAX, 16)].width + 30;
            totalWidth += model.width;
            [models addObject:model];
        }
        self.models = models;
        UIView *leftView;
        for(int i = 0;i < models.count;i ++){
            LMSegmentedModel *model = models[i];
            UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            itemBtn.tag = 100 + i;
            [itemBtn setTitle:model.title forState:UIControlStateNormal];
            [itemBtn setTitleColor:_titleNormalColor forState:UIControlStateNormal];
            [itemBtn setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
            itemBtn.titleLabel.font = _textFont;
            [itemBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollContainerView addSubview:itemBtn];
            [itemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                if(leftView){
                    make.left.mas_equalTo(leftView.mas_right);
                }
                else{
                    make.left.mas_equalTo(0);
                }
                make.top.bottom.mas_equalTo(0);
                make.width.mas_equalTo(model.width);
                if(i == models.count - 1){
                    make.right.mas_equalTo(0);
                }
            }];
            leftView = itemBtn;
            [itemBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            if(i == _currentIndex){
                itemBtn.selected = YES;
                if(!_seletcedLine){
                    _seletcedLine = [[UIImageView alloc]init];
                   
                }
                _seletcedLine.layer.cornerRadius = _selectedLineHeight/2;
                _seletcedLine.backgroundColor = _selectedLineColor;
                [_scrollContainerView addSubview:_seletcedLine];
                CGFloat left = (models[_currentIndex].width - _selectedLineWidth)/2;
                [_seletcedLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(left); make.size.mas_equalTo(CGSizeMake(_selectedLineWidth, _selectedLineHeight));
                   
                    make.bottom.mas_equalTo(0);
                }];
            }
        }
    }
    
    
}

- (void)selectAction:(UIButton *)button
{
    _currentIndex = button.tag - 100;
    [self reloadViewWithhSelectedIndex:button.tag - 100];
    if(_delegate && [_delegate respondsToSelector:@selector(segmentedControl:didSelectedInbdex:)])
    {
        [_delegate segmentedControl:self didSelectedInbdex:button.tag - 100];
    }
}

- (void)scrollToIndex:(NSUInteger)index{
    _currentIndex = index;
    [self reloadViewWithhSelectedIndex:index];
}

- (void)reloadViewWithhSelectedIndex:(NSInteger)index{
    if(!self.titles.count)return;
    if(_segmentedControlType == LMSegmentedControlScreen){
        for(int i = 0;i< _titles.count;i++)
        {
            UIButton *b = (UIButton *)[self viewWithTag:100 + i];
            if(i == index)
            {
                b.selected = YES;
            }
            else
            {
                b.selected = NO;
                b.layer.transformScale = 1.0;
            }
        }
        UIButton *button = [self viewWithTag:100 + index];
        [UIView animateWithDuration:0.2 animations:^{
            button.layer.transformScale = 1.1;
            [self.seletcedLine setCenter:CGPointMake(self->_itemWidth/2 + self->_itemWidth * (button.tag - 100), self->_seletcedLine.center.y)];
            CGFloat offestX = [self.scrollView convertPoint:self.seletcedLine.center toView:self].x;
            if(self.scrollView.contentOffset.x +  (offestX - self.scrollView.width/2) < 0){
                self.scrollView.contentOffset = CGPointMake(0, 0);
            }
            else if(self.scrollView.contentOffset.x +  (offestX - self.scrollView.width/2) > self.scrollView.contentSize.width - self.scrollView.width){
                self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - self.scrollView.width, 0);
            }
            else{
                [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x +  (offestX - self.scrollView.width/2), 0)];
            }
        }];
    }
    else if (_segmentedControlType == LMSegmentedControlAuto){
   
        CGFloat centerX = 0;
        CGFloat tempWidth = 0;
        UIButton *button = [_scrollContainerView viewWithTag:100 + index];
        for(int i = 0;i < self.models.count;i ++){
            UIButton *b = [_scrollContainerView viewWithTag:100 + i];
            
            if(i == index){
                b.selected = YES;
                centerX = tempWidth + self.models[i].width/2;
            }
            else{
                b.selected = NO;
                b.layer.transformScale = 1.0;
            }
            tempWidth += self.models[i].width;
        }
        CGFloat left = centerX - _selectedLineWidth/2;
        [UIView animateWithDuration:0.3 animations:^{
            button.layer.transformScale = 1.1;
            [_seletcedLine mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(left);
            }];
            [_scrollContainerView layoutIfNeeded];
        }];
        CGFloat offest = centerX - _scrollView.width/2;
        CGFloat min = 0;
        CGFloat max = _scrollView.contentSize.width - _scrollView.width;
        if(offest <= min){
            [_scrollView setContentOffset:CGPointZero animated:YES];
           
        }
        else if(offest <= max){
              [_scrollView setContentOffset:CGPointMake(offest, 0) animated:YES];
        }
        else{
            [_scrollView setContentOffset:CGPointMake(max, 0) animated:YES];
        }
    }
}

@end
