//
//  CTOneGoodIndexViewModel.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/5/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTProGoodIndexViewModel.h"
#import <YYText/YYText.h>
@implementation CTProGoodIndexViewModel

+ (id)bindModel:(CTGoodsModel *)model{
    CTProGoodIndexViewModel *viewModel = [CTProGoodIndexViewModel new];
    viewModel.model = model;
    //content
    model.cpy_content = [model.cpy_content stripHTML:YES];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:model.cpy_content];
 
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = 3;
    [content addAttributes:@{NSParagraphStyleAttributeName:style} range:NSMakeRange(0, content.length)];
    viewModel.content = [content copy];

    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(CTProGoodIndexContentWidth, CGFLOAT_MAX) text:content];
    viewModel.contentHeight = layout.textBoundingSize.height;
    
    NSMutableArray *imgModels = [NSMutableArray array];
    for(int i = 0;i < model.itempics.count;i ++){
        CTPictureModel *imgModel = [CTPictureModel new];
        imgModel.img = model.itempics[i];
        [imgModels addObject:imgModel];
    }
    viewModel.imgModels = [imgModels copy];
    viewModel.imgViewHeight = [CTPicturesView heightForItemCount:model.itempics.count row:CTProGoodIndexPictureRow width:CTProGoodIndexPictureWidth lineSpace:CTProGoodIndexPictureLineSpace itemSpace:CTProGoodIndexPictureItemSpace insets:CTProGoodIndexPictureInsets];
    viewModel.commentViewHeight = model.comments.count * (CTProGoodIndexCommentHeight + CTProGoodIndexCommentSpace) - (model.comments.count?CTProGoodIndexCommentSpace:0);
    viewModel.onGoodCellHeight = CTProGoodIndexUserHeight + viewModel.contentHeight + viewModel.imgViewHeight + viewModel.commentViewHeight + 15;
    
    
    //多品
    if(model.item_data){
        NSMutableArray *multipleImgModels = [NSMutableArray array];
        for(int i = 0;i < model.item_data.count;i ++){
            CTPictureModel *imgModel = [CTPictureModel new];
            imgModel.img = model.item_data[i].goods_logo;
            imgModel.price = model.item_data[i].coupon_price;
            [multipleImgModels addObject:imgModel];
        }
        viewModel.imgModels = multipleImgModels;
        viewModel.imgViewHeight = [CTPicturesView heightForItemCount:model.item_data.count row:CTProGoodIndexPictureRow width:CTProGoodIndexPictureWidth lineSpace:CTProGoodIndexPictureLineSpace itemSpace:CTProGoodIndexPictureItemSpace insets:CTProGoodIndexPictureInsets];
        viewModel.multipleGoodsCellHeight = CTProGoodIndexUserHeight + viewModel.contentHeight + viewModel.imgViewHeight + 40;
    }

    
    
    return viewModel;
    
}

@end
