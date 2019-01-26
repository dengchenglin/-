//
//  CTMemberChoicenessView.m
//  CouponTicket
//
//  Created by Dankal on 2019/1/26.
//  Copyright © 2019 Danke. All rights reserved.
//

#import "CTMemberChoicenessView.h"

#import "SDCycleScrollView.h"

#import "CTMemberChoicenessCell.h"

@interface CTMemberChoicenessView()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation CTMemberChoicenessView

ViewInstance(setUp)

- (void)setUp{
    _titleView = NSMainBundleClass(CTMemberTitleView.class);
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
    return [UINib nibWithNibName:NSStringFromClass(CTMemberChoicenessCell.class) bundle:nil];
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
    CTMemberChoicenessCell *myCell = (CTMemberChoicenessCell *)cell;
    [myCell.imageView cl_setImageWithImg:[UIImage imageWithColor:RGBColor(245, 245, 245)]];
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

@end
