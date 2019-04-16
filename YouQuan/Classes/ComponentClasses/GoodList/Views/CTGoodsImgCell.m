//
//  CTGoodsImgCell.m
//  YouQuan
//
//  Created by dengchenglin on 2019/4/16.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodsImgCell.h"

@implementation CTGoodsImgCell

+ (CGFloat)heightForImgSize:(CGSize)imgSize{
    CGSize size = CGSizeMake(CTGoodsImgCellWidth, CTGoodsImgCellWidth/imgSize.width * imgSize.height);
    return size.height + 5;
}

@end
