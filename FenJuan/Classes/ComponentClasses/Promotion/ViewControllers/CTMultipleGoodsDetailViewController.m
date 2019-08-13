//
//  CTMultipleGoodsDetailViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/13.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMultipleGoodsDetailViewController.h"
#import "CTGoodIndexVerticalCell.h"
@interface CTMultipleGoodsDetailViewController ()

@end

@implementation CTMultipleGoodsDetailViewController

- (void)setUpUI{
    self.title = @"多品推荐";
    self.isCollectionView = YES;
    self.canLoadMore = NO;
    self.canRefresh = NO;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CTGoodIndexVerticalCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(CTGoodIndexVerticalCell.class)];
 
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(8, 10, 0, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CTGoodIndexVerticalCellSize;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CTGoodIndexVerticalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CTGoodIndexVerticalCell.class) forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService] fj_goodDetailViewControllerWithGoodId:self.datas[indexPath.row].item_id];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
