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

@end


@implementation CTSortButton

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
            if(self.upDownControl.status == CTUpSortStatusNormal){
                self.upDownControl.status = self.defaultStatus;
            }
            else if (self.upDownControl.status == CTUpSortStatusUp){
                self.upDownControl.status = CTUpSortStatusDown;
            }
            else if (self.upDownControl.status == CTUpSortStatusDown){
                self.upDownControl.status = CTUpSortStatusUp;
            }
        }
        else{
            if(self.upDownControl.status == CTUpSortStatusNormal){
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
        [self.upDownControlView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(10);
        }];
       
    }
    else{
        [self.upDownControlView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
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

- (void)reloadView{
    if(_selected){
        _titleLabel.textColor = _selectedColor;
    }
    else{
        _titleLabel.textColor = _normalColor;
    }
}

@end
