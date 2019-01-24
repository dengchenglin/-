//
//  CTUpDownControl.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTUpDownControl.h"

@interface CTUpDownControl()

@property (weak, nonatomic) IBOutlet UIImageView *upImageView;
@property (weak, nonatomic) IBOutlet UIImageView *downImageView;
@property (nonatomic, strong) UIImage *normalUpImage;
@property (nonatomic, strong) UIImage *selectedUpImage;
@property (nonatomic, strong) UIImage *normalDownImage;
@property (nonatomic, strong) UIImage *selectedDownImage;
@property (nonatomic, strong) UIImage *originUpImage;
@property (nonatomic, strong) UIImage *originDownImage;
@end

@implementation CTUpDownControl
{
    UIImage *_originImage;
}
ViewInstance(setUp)

- (void)setUp{
    _status = CTSortStatusNormal;
    _normalColor = RGBColor(153, 153, 153);
    _selectedColor = CTColor;
    _originUpImage = [UIImage imageNamed:@"ic_nav_up_gray"];
    _originDownImage = [UIImage imageNamed:@"ic_nav_down_gray"];
    
    _normalUpImage = [_originUpImage imageWithColor:_normalColor];
    _selectedUpImage = [_originUpImage imageWithColor:_selectedColor];
    
    _normalDownImage = [_originDownImage imageWithColor:_normalColor];
    _selectedDownImage = [_originDownImage imageWithColor:_selectedColor];
}

- (void)setStatus:(CTSortStatus)status{
    _status = status;
    [self reloadView];
}
- (void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor;
   _normalUpImage = [_originUpImage imageWithColor:_normalColor];
    _normalDownImage = [_originDownImage imageWithColor:_normalColor];
    [self reloadView];
}

- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    _selectedUpImage = [_originUpImage imageWithColor:_selectedColor];
    _selectedDownImage = [_originDownImage imageWithColor:_selectedColor];
    [self reloadView];
}
- (void)reloadView{
    if(_status == CTSortStatusNormal){
        _upImageView.image = _normalUpImage;
        _downImageView.image = _normalDownImage;
        _upImageView.hidden = NO;
        _downImageView.hidden = NO;
    }
    else if (_status == CTSortStatusUp){
        _upImageView.image = _selectedUpImage;
        _downImageView.image = _normalDownImage;
        _upImageView.hidden = NO;
        _downImageView.hidden = YES;
    }
    else if (_status == CTSortStatusDown){
        _upImageView.image = _normalUpImage;
        _downImageView.image = _selectedDownImage;
        _upImageView.hidden = YES;
        _downImageView.hidden = NO;
    }
}

@end
