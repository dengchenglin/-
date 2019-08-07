//
//  ReCarouselView.h
//  LightMaster
//
//  Created by dengchenglin on 2018/12/14.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ReCarouselView;

@protocol ReCarouselViewDataSoure <NSObject>

@optional

- (NSInteger)numberOfItemForReCarouselView:(ReCarouselView *)reCarouselView;

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndex:(NSInteger)index;

- (id)imageOfItemForIndex:(NSInteger)index reCarouselView:(ReCarouselView *)reCarouselView;

@end

@protocol ReCarouselViewDelegate <NSObject>

- (void)reCarouselView:(ReCarouselView *)reCarouselView didSelectItemAtIndex:(NSInteger)index;

- (void)reCarouselView:(ReCarouselView *)reCarouselView didScrollToIndex:(NSInteger)index;

@end

@interface ReCarouselView : UIView

@property (nonatomic, assign) NSInteger itemNumber;

@property (nonatomic,assign)CGSize itemSize;

@property (nonatomic,strong,readonly)UICollectionView *collectionView;

@property (nonatomic, weak) id <ReCarouselViewDataSoure> dataSoure;

@property (nonatomic, weak) id <ReCarouselViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame itemSize:(CGSize)itemSize;

- (instancetype)initWithSolidFrame:(CGRect)frame itemSize:(CGSize)itemSize;

- (void)reloadData;

- (void)scrollToIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
