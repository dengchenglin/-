//
//  CTJdpDetailViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTJdpDetailViewController.h"
#import "CTGoodIndexVerticalCell.h"

#import "CTNetworkEngine+ThirldTk.h"
@interface CTJdpDetailViewController ()
@property (nonatomic, strong) NSMutableArray<CTGoodsModel *> *dataSources;
@end

@implementation CTJdpDetailViewController

- (void)setUpUI{
    self.isCollectionView = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CTGoodIndexVerticalCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(CTGoodIndexVerticalCell.class)];
    
}

- (void)request{
    [CTRequest hdkJdpDetailWithId:self.Id minId:self.minId callback:^(id data, CLRequest *request, CTNetError error) {
        [self analysisAndReloadWithData:data listKey:@"detail/items" error:error modelClass:CTGoodsModel.class viewModelClass:nil];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSources.count;
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
    cell.model = self.dataSources[indexPath.row];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[CTModuleManager goodListService] fj_goodDetailViewControllerWithGoodId:self.dataSources[indexPath.row].item_id];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
