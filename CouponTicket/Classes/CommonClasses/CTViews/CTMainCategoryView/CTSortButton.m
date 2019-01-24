//
//  CTSortButton.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSortButton.h"


@interface CTSortButton()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *upDownControlView;

@property (nonatomic, strong) CTUpDownControl *upDownControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upDownControlWidth;

@end


@implementation CTSortButton
@synthesize status = _status;

- (CTSortStatus)status{
    return self.upDownControl.status;
}

- (void)setStatus:(CTSortStatus)status{
    _status = status;
    self.upDownControl.status = _status;
}



- (void)awakeFromNib{
    [super awakeFromNib];
    _upDownControl = NSMainBundleClass(CTUpDownControl.class);
    [self.upDownControlView addSubview:_upDownControl];
    
    [_upDownControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.sorted = NO;
    
    @weakify(self)
    [self addActionWithBlock:^(id target) {
        @strongify(self)
        if(self.selected){
            if(self.upDownControl.status == CTSortStatusNormal){
                self.upDownControl.status = self.defaultStatus;
            }
            else if (self.upDownControl.status == CTSortStatusUp){
                self.upDownControl.status = CTSortStatusDown;
            }
            else if (self.upDownControl.status == CTSortStatusDown){
                self.upDownControl.status = CTSortStatusUp;
            }
        }
        else{
            if(self.upDownControl.status == CTSortStatusNormal){
                self.upDownControl.status = self.defaultStatus;
            }
        }
        if(self.clickBlock){
            self.clickBlock(self);
        }
    }];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = _title;
}

- (void)setSorted:(BOOL)sorted{
    _sorted = sorted;
    if(_sorted){
        self.upDownControlWidth.constant = 10;
        [self layoutIfNeeded];
    }
    else{
        self.upDownControlWidth.constant = 0;
        [self layoutIfNeeded];
    }
}

- (void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor;
    [self reloadView];
}

- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    [self reloadView];
}

- (void)setSelected:(BOOL)selected{
    _selected = selected;
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

//后期优化成异步调用
- (void)reloadView{
    if(_selected){
        _titleLabel.textColor = _selectedColor;
    }
    else{
        _titleLabel.textColor = _normalColor;
    }
    _upDownControl.normalColor = _upDownNormalColor;
    _upDownControl.selectedColor = _upDownSelectedColor;
}

@end
