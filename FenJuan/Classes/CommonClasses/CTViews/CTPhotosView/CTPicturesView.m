//
//  CTPicturesView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTPicturesView.h"
@interface CTPicturesPriceView:UIView

@property (nonatomic, strong) UILabel *symbolLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, copy) NSString *price;
@end
@implementation CTPicturesPriceView

ViewInstance(setUp)
- (void)setUp{
    UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic_daren_details_bott"]];
    [self addSubview:backgroundImageView];
    _symbolLabel = [[UILabel alloc]init];
    _symbolLabel.textColor = [UIColor whiteColor];
    _symbolLabel.text = @"¥";
    _symbolLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:_symbolLabel];
    
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.textColor = [UIColor whiteColor];
    _priceLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_priceLabel];
    
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [backgroundImageView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
  
    [_symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.width.mas_equalTo(10);
        make.bottom.mas_equalTo(-3);
        make.right.mas_equalTo(_priceLabel.mas_left);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-6);
        make.top.bottom.mas_equalTo(0);
    }];
    
}

- (void)setPrice:(NSString *)price{
    _price = price;
    _priceLabel.text = price;
}

@end

@implementation CTPictureModel
@end

@interface CTPictureItem:UIView

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic, strong) CTPicturesPriceView *priceView;

@property (nonatomic, strong) CTPictureModel *model;
@end

@implementation CTPictureItem


- (CTPicturesPriceView *)priceView{
    if(!_priceView){
        _priceView = [CTPicturesPriceView new];
        _priceView.hidden = YES;
        [self addSubview:_priceView];
        [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(20);
            make.bottom.mas_equalTo(-3);
            make.width.mas_greaterThanOrEqualTo(44);
        }];
    }
    return _priceView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = CTBackGroundGrayColor;
        _imageView.layer.masksToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.borderWidth = LINE_WIDTH;
        _imageView.layer.borderColor = RGBColor(245, 245, 245).CGColor;
        [self addSubview:_imageView];

        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
   _imageView.frame = self.bounds;
}
- (void)setModel:(CTPictureModel *)model{
    _model = model;
    [_imageView cl_setImageWithImg:_model.img];
    if(_model.price){
        self.priceView.hidden = NO;
        self.priceView.price = _model.price;
    }
}


@end

@interface CTPicturesView()

@property (nonatomic, strong)UIButton *addButton;

@property (nonatomic, strong)NSMutableArray <CTPictureItem *>*items;

@property (nonatomic, strong)NSLock *lock;

@end

@implementation CTPicturesView

ViewInstance(setUp)

- (void)setUp{
    _rowCount = 3;
    _itemSpace = 10;
    _lineSpace = 10;
}

- (NSLock *)lock{
    if(!_lock){
        _lock = [NSLock new];
    }
    return _lock;
}

//装载UIImage的视图容器
- (NSMutableArray<CTPictureItem *> *)items{
    if(!_items){
        _items = [NSMutableArray array];
    }
    return _items;
}

- (CTPictureItem *)itemForIndex:(NSInteger)index{
    CTPictureItem *item = [self.items safe_objectAtIndex:index];
    if(!item){
        [_lock lock];
        item = [[CTPictureItem alloc]init];
        [self.items addObject:item];
        [_lock unlock];
    }
    return item;
}

- (void)setModels:(NSArray<CTPictureModel *> *)models{
    _models = [models copy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadView];
    });
}

- (void)reloadView{
    if(!self.width)return;
    NSInteger count = self.models.count;
    CGFloat width = [self widthForItem];
    CGFloat height = width;
    for(int i = 0;i < count;i ++){
        CTPictureItem *item = [self itemForIndex:i];
        item.tag = 100 + i;

        [item setFrame:CGRectMake(i%_rowCount * (width + _itemSpace), _insets.top + i/_rowCount * (_lineSpace + height), width, height)];
        [self addSubview:item];
        item.model = self.models[i];
        
      
        __weak typeof(self) weakSelf = self;
        [item addActionWithBlock:^(UIView *target) {
            if(weakSelf.clickItemBlock){
                weakSelf.clickItemBlock(target.tag - 100);
            }
        }];
    }
    for(int i = 0;i < self.items.count;i ++){
        CTPictureItem *item = [self.items safe_objectAtIndex:i];
        item.hidden = (i<count)?NO:YES;
    }

}

- (NSArray<UIImage *> *)images{
    NSMutableArray *array = [NSMutableArray array];
    for(int i = 0;i < self.items.count;i ++){
        CTPictureItem *item = [self.items safe_objectAtIndex:i];
        if(!item.hidden){
            [array addObject:item.imageView.image?:[UIImage new]];
        }
    }
    return [array copy];
}


#pragma mark -helper
- (CGFloat)widthForItem{
    return (self.width - (_rowCount - 1) * _itemSpace - _insets.left - _insets.right)/_rowCount;
}

- (CGFloat)heightForItemCount:(NSInteger)count{
    if(count == 0){
        return 0;
    }
    CGFloat itemWidth = [self widthForItem];
    CGFloat itemHeight = itemWidth;
    CGFloat calculativeHeight = itemHeight + _lineSpace;
    NSInteger lineCount = (count + _rowCount - 1)/_rowCount;
    return lineCount *calculativeHeight - _lineSpace + _insets.top + _insets.bottom;
}

+ (CGFloat)heightForItemCount:(NSInteger)count row:(NSInteger)row width:(CGFloat)width lineSpace:(CGFloat)lineSpace itemSpace:(CGFloat)itemSpace insets:(UIEdgeInsets)insets{
    if(count == 0){
        return 0;
    }
    CGFloat itemWidth = (width - (row - 1) * itemSpace - insets.left - insets.right)/row;
    CGFloat itemHeight = itemWidth;
    CGFloat calculativeHeight = itemHeight + lineSpace;
    NSInteger lineCount = (count + row - 1)/row;
    CGFloat height = lineCount *calculativeHeight - lineSpace + insets.top + insets.bottom;
    if(height < 0)height = 0;
    return height;
}
@end
