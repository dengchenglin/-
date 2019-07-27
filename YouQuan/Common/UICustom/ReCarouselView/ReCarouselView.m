//
//  ReCarouselView.m
//  LightMaster
//
//  Created by dengchenglin on 2018/12/14.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "ReCarouselView.h"

#import "SolidLayout.h"

@interface ReCarouselCell : UICollectionViewCell

@property (nonatomic ,copy) id image;

@property (nonatomic ,strong) UIImageView *imageView;

@end

@implementation ReCarouselCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]init];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.backgroundColor = RGBColor(245, 245, 245);
        [self.contentView addSubview:_imageView];
  
    }
    return self;
}
- (void)layoutSubviews{
    [_imageView setFrame:self.bounds];
}

- (void)setImage:(id)image{
    _image = image;
    if([_image isKindOfClass:[NSString class]]){
        if([_image hasPrefix:@"http"]){
            [_imageView sd_setImageWithURL:[NSURL URLWithString:_image]];
        }
        else {
            _imageView.image = [UIImage imageNamed:_image];
        }
    }
    else if([_image isKindOfClass:[UIImage class]]){
        _imageView.image = _image;
    }
    
}

@end

@interface ReCarouselView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,copy)NSArray *indexOfItems;

@end

@implementation ReCarouselView
{
    CGFloat _elementWidth;
    NSInteger _addCount;
    UICollectionViewFlowLayout *_layout;
    BOOL setInitOffested;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _itemSize = frame.size;
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame itemSize:(CGSize)itemSize{
    if(self = [super initWithFrame:frame]){
        _itemSize = itemSize;
        _layout = [UICollectionViewFlowLayout new];
        [self setUp];
    }
    return self;
}

- (instancetype)initWithSolidFrame:(CGRect)frame itemSize:(CGSize)itemSize{
    if(self = [super initWithFrame:frame]){
        _itemSize = itemSize;
        _layout = [SolidLayout new];
        [self setUp];
    }
    return self;
}

-(void)setUp{
    
    _elementWidth = _itemSize.width;
   
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _layout.itemSize = _itemSize;
    CGFloat left_right = (self.bounds.size.width - _layout.itemSize.width)/2;
    CGFloat top_bottom = (self.bounds.size.height - _layout.itemSize.height)/2;
    _layout.sectionInset = UIEdgeInsetsMake(top_bottom, left_right, top_bottom, left_right);
    _layout.minimumInteritemSpacing = 10;
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _elementWidth = _itemSize.width + ((UICollectionViewFlowLayout *)_layout).minimumInteritemSpacing;
    
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.decelerationRate = 0.01;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    if(![_layout isKindOfClass:[SolidLayout class]]){
        _collectionView.pagingEnabled = YES;
    }
    [self.collectionView registerClass:ReCarouselCell.class forCellWithReuseIdentifier:NSStringFromClass(ReCarouselCell.class)];
    [self addSubview:_collectionView];
    
}

- (NSInteger)itemNumber{
    if(_dataSoure && [_dataSoure respondsToSelector:@selector(numberOfItemForReCarouselView:)]){
        _itemNumber = [_dataSoure numberOfItemForReCarouselView:self];
    }
    return _itemNumber;
}

- (void)setItemSize:(CGSize)itemSize{
    _itemSize = itemSize;
    for(UIView *view in self.subviews){
        [view removeFromSuperview];
    }
    [self setUp];
    [self reloadData];
}

- (void)reloadData{
    [self reconstructionData];
}

- (void)scrollToIndex:(NSInteger)index{
    if(!self.indexOfItems.count)return;
    
    if(_collectionView.contentOffset.x > (index + _addCount) * _elementWidth){
        [_collectionView setContentOffset:CGPointMake((_itemNumber + index + _addCount) * _elementWidth, 0) animated:YES];
    }
    else{
        [_collectionView setContentOffset:CGPointMake((index + _addCount) * _elementWidth, 0) animated:YES];
    }
}

- (void)reconstructionData{
    
    NSInteger totalCount = self.itemNumber;
    
    NSMutableArray *indexOfItems = [NSMutableArray array];
    for (NSInteger i = 0;i < self.itemNumber;i++){
        [indexOfItems addObject:@(i)];
    }
    self.indexOfItems = indexOfItems;
    
    if(totalCount < 2){
        
        [self reloadCollectionView];
        
        return;
    }
    
    
    _addCount = self.collectionView.frame.size.width/_elementWidth + 1;
    
    if(self.itemNumber < _addCount){
        
        [self reloadCollectionView];
        return;
    }
    
    NSMutableArray *forwardArr = [NSMutableArray array];
    for (NSInteger i = 0;i < _addCount;i++){
        [forwardArr addObject: @(i)];
    }
    
    NSMutableArray *blewArr = [NSMutableArray array];
    for (NSInteger i = self.itemNumber - _addCount;i < self.itemNumber;i++){
        [blewArr addObject: @(i)];
        
    }
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < _addCount;i ++){
        [array addObject:blewArr[i]];
    }
    for (NSInteger i = 0; i < self.itemNumber;i ++){
        [array addObject:@(i)];
    }
    for (NSInteger i = 0; i < _addCount;i ++){
        [array addObject:forwardArr[i]];
    }
    
    self.indexOfItems = array;
    [self reloadCollectionView];
}
- (void)reloadCollectionView{
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointMake(_addCount *_elementWidth, 0)];
    if(self.indexOfItems.count > 1){
        [self scrollViewDidEndDecelerating:_collectionView];
    }
    else{
        if(_delegate && [_delegate respondsToSelector:@selector(reCarouselView:didScrollToIndex:)]){
            [_delegate reCarouselView:self didScrollToIndex:0];
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self setContentOffestX];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint originOffset = [_collectionView.collectionViewLayout targetContentOffsetForProposedContentOffset:scrollView.contentOffset withScrollingVelocity:CGPointZero];
    [UIView animateWithDuration:0.3 animations:^{
        self.collectionView.contentOffset = originOffset;
    } completion:^(BOOL finished) {
        if(_delegate && [_delegate respondsToSelector:@selector(reCarouselView:didScrollToIndex:)]){
            NSInteger tempIndex = (_collectionView.contentOffset.x + self.width/2)/_elementWidth;
            NSInteger index = [self.indexOfItems[tempIndex] integerValue];
            [_delegate reCarouselView:self didScrollToIndex:index];
        }
    }];
 
    

}


- (void)setContentOffestX{
    if(self.indexOfItems.count < 2)return;
    CGFloat rightOffestX = (self.indexOfItems.count - _addCount) * _elementWidth;
    if(_collectionView.contentOffset.x > rightOffestX){
        _collectionView.contentOffset = CGPointMake(_addCount * _elementWidth, _collectionView.contentOffset.y);
        
    }
    if(_collectionView.contentOffset.x < 0){
        _collectionView.contentOffset = CGPointMake((self.indexOfItems.count - 2 *_addCount) * _elementWidth, _collectionView.contentOffset.y);
 
    }

}


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.indexOfItems.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _itemSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{

    if(self.dataSoure && [self.dataSoure respondsToSelector:@selector(collectionView:cellForItemAtIndex:)]){
        return [self.dataSoure collectionView:collectionView cellForItemAtIndex:[self.indexOfItems[indexPath.row] integerValue]];
    }
    if(self.dataSoure && [self.dataSoure respondsToSelector:@selector(imageOfItemForIndex:reCarouselView:)]){
        ReCarouselCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(ReCarouselCell.class) forIndexPath:indexPath];
        cell.image = [self.dataSoure imageOfItemForIndex:[self.indexOfItems[indexPath.row] integerValue] reCarouselView:self];
        return cell;
    }
    return [UICollectionViewCell new];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(_delegate && [_delegate respondsToSelector:@selector(reCarouselView:didSelectItemAtIndex:)]){
        [_delegate reCarouselView:self didSelectItemAtIndex:[self.indexOfItems[indexPath.row] integerValue]];
    }
    
}

@end
