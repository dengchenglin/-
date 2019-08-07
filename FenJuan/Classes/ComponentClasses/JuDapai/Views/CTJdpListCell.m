//
//  CTJdpListCell.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/17.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTJdpListCell.h"
#import "CTJdpGoodsItem.h"
@interface CTJdpListCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation CTJdpListCell

ViewInstance(setUp)
- (void)setUp{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 4;
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [_collectionView setCollectionViewLayout:layout];
    _collectionView.alwaysBounceVertical = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CTJdpGoodsItem.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(CTJdpGoodsItem.class)];
    
    @weakify(self)
    [_lookMoreButton addActionWithBlock:^(id target) {
        @strongify(self)
        if(self.delegate && [self.delegate respondsToSelector:@selector(didClickMoreWithIndex:)]){
            [self.delegate didClickMoreWithIndex:self.index];
        }
    }];
    
}
- (void)setModel:(CTJdpIndexModel *)model{
    _model = model;
    [_shopLogo sd_setImageWithURL:[NSURL URLWithString:_model.brand_logo]];
    _shopTitleLabel.text = _model.tb_brand_name;
    [self.collectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.item.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CTJdpListItemSize;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CTJdpGoodsItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CTJdpGoodsItem.class) forIndexPath:indexPath];
    cell.model = self.model.item[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didClickItemWithModel:)]){
        [self.delegate didClickItemWithModel:self.model.item[indexPath.row]];
    }
}

@end
