//
//  CTPhotoView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/30.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTPhotoView.h"

#import "LMPhotoBrower.h"

#import "DKUploadData.h"

@interface CTPhotoItemView:UIView

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIButton *closeBtn;

@property (nonatomic, assign) BOOL isCanEdit;

@end

@implementation CTPhotoItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isCanEdit = YES;
        _imageView = [[UIImageView alloc]init];
        _imageView.backgroundColor = CTBackGroundGrayColor;
        _imageView.layer.masksToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"ic_del_red"] forState:UIControlStateNormal];
        [self addSubview:_closeBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if(_isCanEdit){
        _imageView.frame = CGRectMake(0, 10, self.width - 10, self.height - 20);
        [_closeBtn setFrame:CGRectMake(0, 0, 20, 20)];
        [_closeBtn setCenter:CGPointMake(_imageView.maxX, _imageView.top)];
    }
    else{
        _imageView.frame = self.bounds;
    }
}

- (void)setIsCanEdit:(BOOL)isCanEdit{
    _isCanEdit = isCanEdit;
    _closeBtn.hidden = !_isCanEdit;
    [self setNeedsLayout];
}

@end

@interface CTPhotoView()

@property (nonatomic, strong)UIButton *addButton;

@property (nonatomic, strong)NSMutableArray <CTPhotoItemView *>*itemViews;

@property (nonatomic, strong)NSMutableArray <LMPhotoImageItem *>*imageItems;

@property (nonatomic, strong)NSLock *lock;

@end

@implementation CTPhotoView



ViewInstance(setUp)

- (void)setUp{
    _isCanEdit = YES;
    _rowCount = 3;
    _space = 10;
    _maxCount = 3;
    _autoExtrusion = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadView];
    });
}

- (NSLock *)lock{
    if(!_lock){
        _lock = [NSLock new];
    }
    return _lock;
}
- (UIButton *)addButton{
    if(!_addButton){
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"i_add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

//UImage容器
- (NSMutableArray<LMPhotoImageItem *> *)imageItems{
    if(!_imageItems){
        _imageItems = [NSMutableArray array];
    }
    return _imageItems;
}
//装载UIImage的视图容器
- (NSMutableArray<CTPhotoItemView *> *)itemViews{
    if(!_itemViews){
        _itemViews = [NSMutableArray array];
    }
    return _itemViews;
}

- (CTPhotoItemView *)itemViewForIndex:(NSInteger)index{
    CTPhotoItemView *itemView = [self.itemViews safe_objectAtIndex:index];
    if(!itemView){
        [_lock lock];
        itemView = [[CTPhotoItemView alloc]init];
        [self.itemViews addObject:itemView];
        [_lock unlock];
    }
    return itemView;
}

- (void)setImgs:(NSArray *)imgs{
    _imgs = [imgs copy];
    if(!_imageItems.count){
        [_imageItems removeAllObjects];
        [_imageItems addObjectsFromArray:[_imgs map:^id(NSInteger index, id element) {
            LMPhotoImageItem *item = [LMPhotoImageItem new];
            item.imgUrl = element;
            return item;
        }]];
    }
    [self reloadView];
}

- (void)reloadImg{
    self.imgs = [self.imageItems map:^id(NSInteger index, LMPhotoImageItem *element) {
        return element.imgUrl;
    }];
    if(self.imageCountDidChangedBlock){
        self.imageCountDidChangedBlock(self.imgs.count);
    }
}

- (void)reloadView{
    if(!self.width)return;
    NSInteger count = self.imageItems.count;
    CGFloat width = (self.width - (_rowCount - 1) * _space)/_rowCount;
    CGFloat height = width;
    for(int i = 0;i < count;i ++){
        CTPhotoItemView *itemView = [self itemViewForIndex:i];
        itemView.tag = 100 + i;
        itemView.closeBtn.tag = 200 + i;
        [itemView setFrame:CGRectMake(i%_rowCount * (width + _space), i/_rowCount * (_space + height), width, height)];
        [itemView.closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemView];
        itemView.isCanEdit = _isCanEdit;
        [itemView.imageView ct_setImageWithImg: _imageItems[i].thumbImage?:_imageItems[i].imgUrl];
    }
    for(int i = 0;i < self.itemViews.count;i ++){
        CTPhotoItemView *itemView = [self.itemViews safe_objectAtIndex:i];
        itemView.hidden = (i<count)?NO:YES;
    }
    if(_isCanEdit && count < _maxCount){
        [self.addButton setFrame:CGRectMake(count%_rowCount * (width + _space), count/_rowCount * (_space + height),width, height)];
        [self addSubview:self.addButton];
    }
    else{
        [self.addButton removeFromSuperview];
    }
    if(_autoExtrusion){
        CGFloat totalHeight = [self heightForItemCount:self.imageItems.count];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(totalHeight);
        }];
    }
}


- (void)add{
    [self.superview.superview endEditing:YES];
    CGFloat currentMaxCount = _maxCount - self.imageItems.count;
    [LMPhotoBrower showPhotoActionSheetWithMaxCount:currentMaxCount callback:^(NSArray<LMPhotoImageItem *> *imageItems) {
        [DKUploadData uploadImages:[imageItems map:^id(NSInteger index, LMPhotoImageItem *element) {
            return element.thumbImage?:[UIImage new];
        }] callback:^(NSArray<NSString *> *hashKeys) {
            [imageItems enumerateObjectsUsingBlock:^(LMPhotoImageItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.imgUrl = [hashKeys safe_objectAtIndex:idx];
            }];
            [self.imageItems addObjectsFromArray:imageItems];
            [self reloadView];
            [self reloadImg];
        }];
    }];
}

- (void)close:(UIButton *)button{
    if(self.imageItems.count >= button.tag - 200){
        [self.imageItems removeObjectAtIndex:button.tag - 200];
    }
    [self reloadView];
    [self reloadImg];
}

#pragma mark -helper
- (CGFloat)heightForItemCount:(NSInteger)count{
    CGFloat itemWidth = (self.width - (_rowCount - 1) * _space)/_rowCount;
    CGFloat calculativeHeight = itemWidth + _space;
    if(_isCanEdit && count < _maxCount)count += 1;
    if(count == 0){
        return 0;
    }
    NSInteger lineCount = (count + _rowCount - 1)/_rowCount;
    return lineCount *calculativeHeight - _space;
}

@end
