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

@property (nonatomic, strong) UIImageView *silder;

@property (nonatomic, copy) NSArray<LMSegmentedModel*> *models;

@property (nonatomic, strong) UIImageView *backgroundView;

@end

@implementation LMSegmentedControl{
    UIView *_containerView;
    UIView *_scrollContainerView;
    UIView *_bottomLine;
    CGFloat _itemWidth;
}

ViewInstance(setUp)

- (void)setUp{
    _containerView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    _backgroundView = [UIImageView new];
    [_containerView addSubview:_backgroundView];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    _titleNormalColor = [UIColor colorWithHexString:@"#999999"];
    _titleSelectedColor = [UIColor redColor];
    _selectedLineColor = [UIColor redColor];
    _selectedLineWidth = 20;
    _selectedLineHeight = 2;
    _textFont = [UIFont systemFontOfSize:14];
    _showBottomLine = NO;
   
}
- (void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    _backgroundView.image = _backgroundImage;
}

- (void)setTitles:(NSArray<NSString *> *)titles{
    _titles = [titles copy];
    _currentIndex = 0;
    dispatch_async(dispatch_get_main_queue(), ^{
         [self reloadView];
    });
}
- (void)setShowBottomLine:(BOOL)showBottomLine{
    _showBottomLine = showBottomLine;
    if(_bottomLine){
        [_bottomLine removeFromSuperview];
    }
    if(_showBottomLine){
        if(!_bottomLine){
            _bottomLine = [UIImageView new];
            _bottomLine.backgroundColor = RGBColor(240, 240, 240);
        }
        [self addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(LINE_WIDTH);
        }];
    }
}
- (void)reloadView{
    if(!self.width){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadView];
        });
        return;
    }
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:_containerView.bounds];
        _scrollView.scrollsToTop = NO;
        _scrollView.decelerationRate = 0.2;
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
        if(!_silder){
            _silder = [[UIImageView alloc]init];
            
        }
        _silder.backgroundColor = _selectedLineColor;
        _silder.layer.cornerRadius = _selectedLineHeight/2;
        _silder.clipsToBounds = YES;
        [_scrollView addSubview:_silder];
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
                [_silder setBounds:CGRectMake(0, 0, _selectedLineWidth, _selectedLineHeight)];
                if(_silderStyle == LMSegmentedControlSilderLine)
                {
                    [_silder setCenter:CGPointMake(_itemWidth/2 + _itemWidth * _currentIndex, _containerView.height - _silder.height/2)];
                }else if (_silderStyle == LMSegmentedControlSilderSquare){
                    [_silder setCenter:CGPointMake(_itemWidth/2 + _itemWidth * _currentIndex, _containerView.height/2)];
                }
                
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
            model.title = _titles[i];
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
                if(!_silder){
                    _silder = [[UIImageView alloc]init];
                    
                }
                _silder.layer.cornerRadius = _selectedLineHeight/2;
                _silder.backgroundColor = _selectedLineColor;
                [_scrollContainerView addSubview:_silder];
                CGFloat left = (models[_currentIndex].width - _selectedLineWidth)/2;
                
                
                if(_silderStyle == LMSegmentedControlSilderLine)
                {
                    [_silder mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(left); make.size.mas_equalTo(CGSizeMake(_selectedLineWidth, _selectedLineHeight));
                        
                        make.bottom.mas_equalTo(0);
                    }];
                }else if (_silderStyle == LMSegmentedControlSilderSquare){
                    [_silder mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(left); make.size.mas_equalTo(CGSizeMake(_selectedLineWidth, _selectedLineHeight));
                        
                        make.centerY.mas_equalTo(0);
                    }];
                }
            }
        }
    }
    else if (_segmentedControlType == LMSegmentedControlConstant){
        _scrollContainerView = [UIView new];
        [_scrollView addSubview:_scrollContainerView];
        _scrollView.contentSize = CGSizeMake(_itemSize.width * _titles.count, 0);
        [_scrollContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
            make.height.mas_equalTo(self->_containerView.height);
        }];
        if(!_silder){
            _silder = [[UIImageView alloc]init];
            
        }
        _silder.backgroundColor = _selectedLineColor;
        [_scrollContainerView addSubview:_silder];
        
        UIView *leftView;
        for(int i = 0;i < _titles.count;i ++){
            UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            itemBtn.tag = 100 + i;
            [itemBtn setTitle:_titles[i] forState:UIControlStateNormal];
            itemBtn.titleLabel.numberOfLines = 2;
            [itemBtn setTitleColor:_titleNormalColor forState:UIControlStateNormal];
            [itemBtn setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
            itemBtn.titleLabel.font = _textFont;
            itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            itemBtn.titleLabel.textAlignment =NSTextAlignmentCenter;
            itemBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
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
                make.width.mas_equalTo(_itemSize.width);
                if(i == _titles.count - 1){
                    make.right.mas_equalTo(0);
                }
            }];
            leftView = itemBtn;
            [itemBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
            if(i == _currentIndex){
                itemBtn.selected = YES;
                CGFloat left = _currentIndex *_itemSize.width;
                [_silder mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(left); make.size.mas_equalTo(_itemSize);
                    make.centerY.mas_equalTo(0);
                }];
            }
        }
        [_scrollContainerView layoutIfNeeded];
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
    if(self.clickItemBlock){
        self.clickItemBlock(button.tag - 100);
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
            [self.silder setCenter:CGPointMake(self->_itemWidth/2 + self->_itemWidth * (button.tag - 100), self->_silder.center.y)];
            CGFloat offestX = [self.scrollView convertPoint:self.silder.center toView:self].x;
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            button.layer.transformScale = 1.1;
            [_silder mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(left);
            }];
            [UIView animateWithDuration:0.3 animations:^{
                [_scrollContainerView layoutIfNeeded];
            }];
       
            CGFloat offest = centerX - _scrollView.width/2;
            CGFloat min = 0;
            CGFloat max = _scrollView.contentSize.width - _scrollView.width;
            if(max < 0){
                max = 0;
            }
            if(offest <= min){
                [_scrollView setContentOffset:CGPointZero animated:YES];
                
            }
            else if(offest <= max){
                [_scrollView setContentOffset:CGPointMake(offest, 0) animated:YES];
            }
            else{
                [_scrollView setContentOffset:CGPointMake(max, 0) animated:YES];
            }
        });

    }
    else if (_segmentedControlType == LMSegmentedControlConstant){
        
        UIButton *button = [_scrollContainerView viewWithTag:100 + index];
        for(int i = 0;i < _titles.count;i ++){
            UIButton *b = [_scrollContainerView viewWithTag:100 + i];
            
            if(i == index){
                b.selected = YES;
            }
            else{
                b.selected = NO;
                b.layer.transformScale = 1.0;
            }
        }
        CGFloat left = index * _itemSize.width;
        [UIView animateWithDuration:0.3 animations:^{
            button.layer.transformScale = 1.1;
            [_silder mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(left);
            }];
            [_scrollContainerView layoutIfNeeded];
        }];
        CGFloat offest = index * _itemSize.width + _itemSize.width/2 - _scrollView.width/2;
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
