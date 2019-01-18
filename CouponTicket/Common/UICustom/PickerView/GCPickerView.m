//
//  GCPickerView.m
//  GeiHuiWang
//
//  Created by chenguangjiang on 14-3-10.
//  Copyright (c) 2014年 Dengchenglin. All rights reserved.
//

#import "GCPickerView.h"

#import <objc/runtime.h>

static const int GCPickerViewKey;

@interface GCPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSArray *subTitles;

@property (nonatomic, copy) NSString *currentTitle;

@property(nonatomic,copy)GCPickerCallback callback;

@end
@implementation GCPickerView
{
    UIPickerView *_pickerView;
    UIView *_pickView;
    UILabel *_titleLabel;;
    NSInteger index;
    
}

+ (void)showPickerViewWithSubTitles:(NSArray <NSString *>*)subTitles callback:(GCPickerCallback)callback
{
    [self showPickerViewWithTitle:nil subTitles:subTitles callback:callback];
}
+ (void)showPickerViewWithTitle:(NSString *)title subTitles:(NSArray <NSString *>*)subTitles callback:(GCPickerCallback)callback{
    [self showPickerViewWithTitle:title subTitles:subTitles currentTitle:nil callback:callback];
}

+ (void)showPickerViewWithTitle:(NSString *)title subTitles:(NSArray <NSString *>*)subTitles currentTitle:(NSString *)currentTitle callback:(GCPickerCallback)callback{
    GCPickerView *pickView = [[GCPickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    pickView.title = title;
    pickView.subTitles = subTitles;
    pickView.callback = callback;
    pickView.currentTitle = currentTitle;
    [[UIApplication sharedApplication].keyWindow addSubview:pickView];
    objc_setAssociatedObject([UIApplication sharedApplication].keyWindow, &GCPickerViewKey, pickView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)hiddenPickerView
{
    GCPickerView *pickerView = objc_getAssociatedObject([UIApplication sharedApplication].keyWindow, &GCPickerViewKey);
    if(pickerView){
        [pickerView removeFromSuperview];
    }
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self createView];
    }
    return self;
}
-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = title;
}
-(void)createView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    imageView.backgroundColor = [UIColor blackColor];
    imageView.alpha = 0.3;
    [self addSubview:imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancel)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    _pickView  = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 220*AUTO_Y, self.width, 220*AUTO_Y)];
 
    UIView *sureView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 44)];
    sureView.backgroundColor = [UIColor colorWithHexString:@"#6FBA27"];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.width - 120)/2 , 0, 120, sureView.height)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:15 ];
    _titleLabel.text = _title;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [sureView addSubview:_titleLabel];
    
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setFrame:CGRectMake(sureView.width - 50 , 0, 40 , sureView.height)];
    sureBtn.titleLabel.font = FONT_PFRG_SIZE(14);
    [sureBtn setTitle:@"OK" forState:UIControlStateNormal];
    sureBtn.imageEdgeInsets = UIEdgeInsetsMake(9 , 10 , 9 , 10 );
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [sureView addSubview:sureBtn];
    [_pickView addSubview:sureView];
    
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, sureView.maxY, _pickView.width, _pickView.height - sureView.maxY)];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [_pickView addSubview:_pickerView];
    [self addSubview:_pickView];

}

- (void)setCurrentTitle:(NSString *)currentTitle{
    _currentTitle = currentTitle;
    __block NSInteger currentIndex = 0;
    [self.subTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isEqualToString:self->_currentTitle]){
            currentIndex = idx;
            *stop = YES;
        }
    }];
    [_pickerView selectRow:currentIndex inComponent:0 animated:YES];
    index = currentIndex;
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.subTitles.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.subTitles objectAtIndex:row];
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 28 ;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.backgroundColor = [UIColor whiteColor];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setFont:[UIFont systemFontOfSize:16 ]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    index = row;
}
-(void)cancel
{
    [self removeFromSuperview];
}
-(void)sure
{
    self.callback(index);
    [self removeFromSuperview];
}
@end
