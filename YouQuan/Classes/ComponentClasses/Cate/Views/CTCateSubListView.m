//
//  CTCateSubListView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTCateSubListView.h"
#import "CTNetworkEngine+Index.h"
#import "LineLayout.h"

@interface CTCateSubCollectionCell :UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end


@implementation CTCateSubCollectionCell

@end

@interface CTCateSubListView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CTCateSubListView


ViewInstance(setUp)
- (void)setUp{
    LineLayout *layout = [[LineLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.decelerationRate = 0.1;
    _collectionView.alwaysBounceVertical = YES;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(CTCateSubCollectionCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(CTCateSubCollectionCell.class)];
    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setModel:(CTCategoryModel *)model{
    _model = model;
    self.datas = @[];
    [self.collectionView reloadData];
    [CTRequest cateWithPid:_model.uid callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
             self.datas = [CTCategoryModel yy_modelsWithDatas:data];
            [self.collectionView reloadData];
        }
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _datas.count;
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 25;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 25;
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CTCateSubListCellSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CTCateSubCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CTCateSubCollectionCell.class) forIndexPath:indexPath];
    [cell.imageVIew cl_setImageWithImg:self.datas[indexPath.row].img];
    cell.textLabel.text = self.datas[indexPath.row].title;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.indexChangedBlock){
        self.indexChangedBlock(indexPath.row);
    }
}

@end
