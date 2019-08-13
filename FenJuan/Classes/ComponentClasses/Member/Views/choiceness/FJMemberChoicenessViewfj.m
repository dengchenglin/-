//
//  CTMemberChoicenessView.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/26.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "FJMemberChoicenessViewfj.h"

#import "SDCycleScrollView.h"

#import "FJMemberChoicenessCellfj.h"

#import "UIView+YYAdd.h"

@interface FJMemberChoicenessViewfj()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation FJMemberChoicenessViewfj

ViewInstance(setUp)

- (void)setUp{
    _titleView = NSMainBundleClass(FJMemberTitleView.class);
    _titleView.titleLabel.text = @"会员精选";
    [self addSubview:_titleView];

    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    _cycleScrollView = [[SDCycleScrollView alloc]init];
    _cycleScrollView.backgroundColor = RGBColor(240, 240, 240);
    _cycleScrollView.delegate = self;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
 
    _cycleScrollView.pageControlDotSize = CGSizeMake(7, 7);
    
    UIView *currentPageDotView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    currentPageDotView.opaque = 0;
    currentPageDotView.layer.cornerRadius = 5;
    currentPageDotView.backgroundColor = RGBColor(255, 97, 36);
    UIImage *currentPageDotImage = [currentPageDotView snapshotImage];
    
    UIView *pageDotView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    pageDotView.opaque = 0;
    pageDotView.layer.cornerRadius = 5;
    pageDotView.backgroundColor = RGBAColor(20, 20, 20, 0.2);
    UIImage *pageDotImage = [pageDotView snapshotImage];
    
    _cycleScrollView.currentPageDotImage = currentPageDotImage;
    _cycleScrollView.pageDotImage = pageDotImage;
    [self addSubview:_cycleScrollView];
    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView.mas_bottom);
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(163);
    }];

}

- (void)setImgs:(NSArray<NSString *> *)imgs{
    _imgs = [imgs copy];
    self.cycleScrollView.imageURLStringsGroup = _imgs;
}

- (UINib *)customCollectionViewCellNibForCycleScrollView:(SDCycleScrollView *)view{
    return [UINib nibWithNibName:NSStringFromClass(FJMemberChoicenessCellfj.class) bundle:nil];
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
    FJMemberChoicenessCellfj *myCell = (FJMemberChoicenessCellfj *)cell;
    [myCell.imageView cl_setImageWithImg:self.imgs[index]];
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if(self.clickItemBlock){
        self.clickItemBlock(index);
    }
}

@end
