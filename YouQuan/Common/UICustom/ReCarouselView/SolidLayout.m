//
//  SolidLayout.m
//  LightMaster
//
//  Created by dengchenglin on 2018/12/14.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import "SolidLayout.h"

@implementation SolidLayout
- (void)prepareLayout
{
    [super prepareLayout];
}

- (CGSize)collectionViewContentSize
{
    return [super collectionViewContentSize];
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *visibleItemArray = [super layoutAttributesForElementsInRect:visibleRect];
    
    for (UICollectionViewLayoutAttributes *attributes in visibleItemArray)
    {
        
        CGFloat leftMargin = attributes.center.x - self.collectionView.contentOffset.x;
        
        CGFloat halfCenterX = self.collectionView.frame.size.width / 2;
        
        CGFloat absOffset = fabs(halfCenterX - leftMargin);
        
        CGFloat scale = 1 - absOffset / halfCenterX;
        
        CATransform3D transformScale =  CATransform3DMakeScale(0.96 + scale * 0.04, 0.96 + scale * 0.04, 1);
        
        attributes.transform3D = transformScale;
    }
    NSArray *attributesArr = [[NSArray alloc] initWithArray:visibleItemArray copyItems:YES];
    return attributesArr;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    [super shouldInvalidateLayoutForBoundsChange:newBounds];
    return YES;
}




- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    CGFloat minOffset = CGFLOAT_MAX;
    
    CGFloat horizontalCenter = proposedContentOffset.x + self.collectionView.bounds.size.width / 2;
    
    CGRect visibleRec = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *visibleAttributes = [super layoutAttributesForElementsInRect:visibleRec];
    
    for (UICollectionViewLayoutAttributes *atts in visibleAttributes)
    {
        
        CGFloat itemCenterX = atts.center.x;
        
        if (fabs(itemCenterX - horizontalCenter) <= fabs(minOffset)) {
            minOffset = itemCenterX - horizontalCenter;
        }
        
    }
    
    CGFloat centerOffsetX = proposedContentOffset.x + minOffset;
    if (centerOffsetX < 0) {
        centerOffsetX = 0;
    }
    
    if (centerOffsetX > self.collectionView.contentSize.width -(self.sectionInset.left + self.sectionInset.right + self.itemSize.width)) {
        centerOffsetX = floor(centerOffsetX);
    }
    return CGPointMake(centerOffsetX, proposedContentOffset.y);
}

@end
