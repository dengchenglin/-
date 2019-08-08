//
//  CTGoodsImgCell.h
//  YouQuan
//
//  Created by dengchenglin on 2019/4/16.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CTGoodsImgCellWidth (SCREEN_WIDTH - 20)

@interface FJGoodsImgCellfj : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;

+ (CGFloat)heightForImgSize:(CGSize)imgSize;

@end
