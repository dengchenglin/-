//
//  HorizontalCompactLayout.m
//  HorizontalCompactView
//
//  Created by peikua on 16/8/19.
//  Copyright © 2016年 peikua. All rights reserved.
//

#import "CLHorizontalCompactLayout.h"

@implementation CLHorizontalCompactLayout

-(id)init
{
    self = [super init];
    if (self) {
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
    }
    return self;
}
-(void)prepareLayout
{
    [super prepareLayout];
    
}
-(CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
}

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for(int i = 0; i < attributes.count; ++i) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];

        NSInteger maximumSpacing = self.minimumInteritemSpacing;
        if((id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate && [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]){
            maximumSpacing = [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:currentLayoutAttributes.indexPath.section];
        }
        
        UIEdgeInsets inset = self.sectionInset;
        if((id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate && [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]){
            inset = [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:currentLayoutAttributes.indexPath.section];
        }
        
        if(currentLayoutAttributes.representedElementKind){
            continue;
        }
        //核心代码
        
        if(currentLayoutAttributes.indexPath.row == 0){
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = inset.left;
            currentLayoutAttributes.frame = frame;
        }
        if(currentLayoutAttributes.indexPath.row <= 0){
            continue;
        }
        UICollectionViewLayoutAttributes *prevLayoutAttributes;
        if(i != 0){
            prevLayoutAttributes = attributes[i - 1];
        }
        else{
            prevLayoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:currentLayoutAttributes.indexPath.row - 1 inSection:currentLayoutAttributes.indexPath.section]];
        }
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        if(prevLayoutAttributes.frame.origin.y != currentLayoutAttributes.frame.origin.y){
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = inset.left;
            currentLayoutAttributes.frame = frame;
        }
        else if((origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width - inset.left - inset.right) && (prevLayoutAttributes.indexPath.section == currentLayoutAttributes.indexPath.section)) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    return attributes;
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    return attributes;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    return NO;
}
@end
