//
//  XMGMineOrderReadCell.h
//  喜马拉雅FM
//
//  Created by 弓虽_子 on 16/8/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMGAudioListModel;
@interface XMGMineOrderReadCell : UITableViewCell

+ (instancetype)mineOrderReadCell;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic, strong) XMGAudioListModel *audioM;

@end
