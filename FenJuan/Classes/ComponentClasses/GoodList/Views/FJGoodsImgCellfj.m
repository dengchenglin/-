//
//  CTGoodsImgCell.m
//  YouQuan
//
//  Created by dengchenglin on 2019/4/16.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJGoodsImgCellfj.h"

@implementation FJGoodsImgCellfj

+ (CGFloat)heightForImgSize:(CGSize)imgSize{
    if(imgSize.width==0|| imgSize.height==0)return 0;
    CGSize size = CGSizeMake(CTGoodsImgCellWidth, CTGoodsImgCellWidth/imgSize.width * imgSize.height);
    return size.height + 5;
}

@end
