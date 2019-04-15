//
//  CTTabBarItem.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTTabBarItem.h"

@interface CTTabBarItem ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, copy) void(^block)(id sender);

@end

@implementation CTTabBarItem

ViewInstance(setUp)

- (UITapGestureRecognizer *)tap{
    if(!_tap){
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    }
    return _tap;
}
- (void)setUp{
    
    _imageView = [[UIImageView alloc]init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    _textLabel = [[UILabel alloc]init];
    _textLabel.font = [UIFont systemFontOfSize:10];
    _textLabel.textColor = HexColor(@"#666666");
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_textLabel];
    
}

- (void)layoutSubviews{
    {
        [_imageView setBounds:CGRectMake(0, 0, 21, 21)];
        [_imageView setCenter:CGPointMake(self.width/2, self.height/2 - 7)];
        [_textLabel setFrame:CGRectMake(0, _imageView.maxY, self.width, self.height - _imageView.maxY)];
    }
    /*{
     [_imageView setBounds:CGRectMake(0, 0, 37, 37)];
     [_imageView setCenter:CGPointMake(self.width/2, self.height/2)];
     [_textLabel setFrame:CGRectZero];
     
     }*/
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _textLabel.text = title;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    [self reloadData];
}

- (void)setSelectedImage:(UIImage *)selectedImage{
    _selectedImage = selectedImage;
    [self reloadData];
}

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    [self reloadData];
}

- (void)reloadData{
    if(_selected){
        _imageView.image = _selectedImage;
        _textLabel.textColor = CTColor;
    }
    else{
        _imageView.image = _image;
        _textLabel.textColor = HexColor(@"#666666");
    }
}


#pragma mark - TargetEvents

- (void)tapAction{
    if(self.block){
        self.block(self);
    }
}

- (void)addTapGestureRecognizerWithBlock:(void(^)(id sender))block{
    self.block = block;
    [self addGestureRecognizer:self.tap];
}

@end
