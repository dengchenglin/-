//
//  CTGoodSortView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodSortView.h"

#import "CTSortButton.h"
@interface CTGoodSortView()

@property (nonatomic, strong) UIImageView *sildImageView;

@end

@implementation CTGoodSortView
{
    NSArray *_titles;
}
ViewInstance(setUp)

- (void)setUp{
    _titles = @[@"综合",@"销量",@"最新",@"券额",@"价格"];
    _normalColor = RGBColor(153, 153, 153);
    _selectedColor = CTColor;
    _upDownNormalColor = RGBColor(153, 153, 153);
    _upDownSelectedColor = CTColor;
    [self setUpUI];
}
- (void)setUpUI{
    _sildImageView = [[UIImageView alloc]init];
    _sildImageView.hidden = YES;
    _sildImageView.layer.cornerRadius = 12;
    _sildImageView.backgroundColor = RGBColor(255, 199, 38);
    [self addSubview:_sildImageView];
    
    [_sildImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(62, 24));
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    UIView *leftView;
    for(int i = 0;i < _titles.count;i ++){
        CTSortButton *button = NSMainBundleClass(CTSortButton.class);
        button.tag = 100 + i;
        button.normalColor = _normalColor;
        button.selectedColor = _selectedColor;
        button.upDownNormalColor = _upDownNormalColor;
        button.upDownSelectedColor = _upDownSelectedColor;
        button.title = _titles[i];
        [self addSubview:button];
        [button mas_updateConstraints:^(MASConstraintMaker *make) {
            if(leftView){
                make.left.mas_equalTo(leftView.mas_right);
                make.width.mas_equalTo(leftView.mas_width);
            }
            else{
                make.left.mas_equalTo(0);
            }
            if(i == _titles.count - 1){
                make.right.mas_equalTo(0);
            }
            make.top.bottom.mas_equalTo(0);
        }];
        leftView = button;
        
        @weakify(self)
        [button setClickBlock:^(CTSortButton *target) {
            @strongify(self)
            for(int i = 0;i < self->_titles.count; i ++){
                CTSortButton *b = [self viewWithTag:100 + i];
                if(i == target.tag - 100){
                    b.selected = YES;
                }
                else{
                    b.selected = NO;
                    b.status = CTSortStatusNormal;
                }
            }
            [self reloadSildWithIndex:target.tag - 100 animated:YES];
            
            CTGoodSortType type;
            if(self.clickBlock){
                switch (target.tag) {
                    case 100:
                        type = CTGoodSortComprehensive;
                        break;
                    case 101:
                        type = CTGoodSortSales;
                        break;
                    case 102:
                        type = CTGoodSortNewest;
                        break;
                    case 103:
                        type = (target.status == CTSortStatusUp?CTGoodSortDiscountUp:CTGoodSortDiscountDown);
                        break;
                    case 104:
                        type = (target.status == CTSortStatusUp?CTGoodSortPriceUp:CTGoodSortPriceDown);
                        break;
                    default:
                        type = CTGoodSortComprehensive;
                        break;
                }
                self.clickBlock(type);
            }
        }];
    }
    
    //综合默认选中
    CTSortButton *button0 = [self viewWithTag:100];
    button0.selected = YES;

    //券额默认降序
    CTSortButton *button3 = [self viewWithTag:103];
    button3.sorted = YES;
    button3.defaultStatus = CTSortStatusDown;
    //价格默认升序
    CTSortButton *button4 = [self viewWithTag:104];
    button4.sorted = YES;
    button4.defaultStatus = CTSortStatusUp;
    
    [self reloadSildWithIndex:0 animated:NO];
}

- (void)setShowSilder:(BOOL)showSilder{
    _showSilder = showSilder;
    _sildImageView.hidden = !_sildImageView;
}
- (void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor;
    [self reloadView];
}
- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    [self reloadView];
}
- (void)setUpDownNormalColor:(UIColor *)upDownNormalColor{
    _upDownNormalColor = upDownNormalColor;
    [self reloadView];
}
- (void)setUpDownSelectedColor:(UIColor *)upDownSelectedColor{
    _upDownSelectedColor = upDownSelectedColor;
    [self reloadView];
}
- (void)reloadView{
    for(int i = 0; i < _titles.count;i ++){
        CTSortButton *button = [self viewWithTag:100 + i];
        button.selectedColor = _selectedColor;
        button.normalColor = _normalColor;
        button.upDownSelectedColor = _upDownSelectedColor;
        button.upDownNormalColor = _upDownNormalColor;
    }
}

- (void)reloadSildWithIndex:(NSInteger)index animated:(BOOL)animated{
    CGFloat elemnetWidth = SCREEN_WIDTH/_titles.count;
    CGFloat left = index * elemnetWidth + elemnetWidth/2 - 31;
    [self.sildImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
    }];
    if(animated){
        [UIView animateWithDuration:0.3 animations:^{
            [self layoutIfNeeded];
        }];
    }
}


@end
