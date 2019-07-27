//
//  CTIvCodeContainerView.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/6.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTIvCodeContainerView.h"
#import "ReCarouselView.h"
#import <SDWebImage/SDImageCache.h>
@interface CTIvCodeContainerView()<ReCarouselViewDataSoure,ReCarouselViewDelegate>
@property (nonatomic, strong)ReCarouselView *carouselView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) UIImage *currentImage;
@end
@implementation CTIvCodeContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _carouselView = [[ReCarouselView alloc]initWithSolidFrame:CGRectMake(0, 0, self.width, self.height) itemSize:CGSizeMake((self.height - 20) * 0.66, self.height - 20)];
        _carouselView.backgroundColor = RGBColor(245, 245, 245);
        _carouselView.dataSoure = self;
        _carouselView.delegate = self;
        [self addSubview:_carouselView];
    }
    return self;
}

- (void)setImages:(NSArray<UIImage *> *)images{
    _images = images;
    [_carouselView reloadData];
}
#pragma mark - ReCarouselViewDataSoure

- (NSInteger)numberOfItemForReCarouselView:(ReCarouselView *)reCarouselView{
    return self.images.count;
}


- (id)imageOfItemForIndex:(NSInteger)index reCarouselView:(ReCarouselView *)reCarouselView{
    
    return self.images[index];
}

#pragma mark - ReCarouselViewDelegate

- (void)reCarouselView:(ReCarouselView *)reCarouselView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"select %zu",index);
 
}

- (void)reCarouselView:(ReCarouselView *)reCarouselView didScrollToIndex:(NSInteger)index{
    _currentIndex = index;
    self.currentImage = self.images[index];
   
}
@end
