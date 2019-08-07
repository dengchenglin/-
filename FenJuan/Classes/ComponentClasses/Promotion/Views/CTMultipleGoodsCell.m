//
//  CTMultipleGoodsCell.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/7/12.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMultipleGoodsCell.h"
@interface CTMultipleGoodsCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureHeight;

@end
@implementation CTMultipleGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cpyButton.layer.cornerRadius = 12;
    self.cpyButton.layer.borderColor = [UIColor colorWithHexString:@"#F7523F"].CGColor;
    self.cpyButton.layer.borderWidth = LINE_WIDTH;
    self.picturesView.lineSpace = CTProGoodIndexPictureLineSpace;
    self.picturesView.itemSpace = CTProGoodIndexPictureItemSpace;
    self.picturesView.insets = CTProGoodIndexPictureInsets;
    @weakify(self)
    [self.shareButton addActionWithBlock:^(id target) {
        @strongify(self)
        if(self.delegate && [self.delegate respondsToSelector:@selector(didShareWithIndex:)]){
            [self.delegate didShareWithIndex:self.index];
        }
    }];
    
    [self.picturesView setClickItemBlock:^(NSInteger index) {
        @strongify(self)
        if(self.delegate && [self.delegate respondsToSelector:@selector(didClickWithModel:)]){
            [self.delegate didClickWithModel:self.viewModel.model.item_data[index]];
        }
    }];
    
    [self.cpyButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [UIPasteboard generalPasteboard].string = self.contentLabel.attributedText.string;
        [MBProgressHUD showMBProgressHudWithTitle:@"复制成功"];
        
    }];
}

- (void)setViewModel:(CTProGoodIndexViewModel *)viewModel{
    _viewModel = viewModel;
    [_userLogo cl_setImageWithImg:_viewModel.model.app_logo];
    _usernameLabel.text = _viewModel.model.app_name;
    _addTimeLabel.text = _viewModel.model.add_time;
    
    
    _contentLabel.attributedText = _viewModel.content;
    _picturesView.models = _viewModel.imgModels;
  
    //刷新布局
    _contentHeight.constant = _viewModel.contentHeight;
    _pictureHeight.constant = _viewModel.imgViewHeight;
   
    [self.contentView layoutIfNeeded];
}


@end
