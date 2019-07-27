//
//  CTGoodsShareViewController.m
//  HuiJiTalent
//
//  Created by dengchenglin on 2019/6/4.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodsShareViewController.h"
#import "CTNetworkEngine+Goods.h"
#import "CTGoodsShareDescView.h"

@interface CTGoodsShareViewController()
@property (nonatomic, strong) CTGoodsShareDescView *descView;
@end

@implementation CTGoodsShareViewController
- (CTGoodsShareDescView *)descView{
    if(!_descView){
        _descView = NSMainBundleClass(CTGoodsShareDescView.class);
    }
    return _descView;
}
- (void)setUpUI{
    self.title = @"创建分享";
    self.scrollViewAvailable = YES;
    [self.autoLayoutContainerView addSubview:self.descView];
}
- (void)autoLayout{
    [self.descView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)request{
    if(_kind == CTShopTb){
        [CTRequest goodsShareWithId:self.goodId kind:_kind callback:^(id data, CLRequest *request, CTNetError error) {
            if(!error){
                CTGoodsModel *model = [CTGoodsModel yy_modelWithDictionary:data];
                self.descView.viewModel = [CTGoodsViewModel bindModel:model];
            }
        }];
    }
    else if(_kind == CTShopJd){
        [CTRequest goodsShareWithId:self.goodId kind:_kind callback:^(id data, CLRequest *request, CTNetError error) {
            if(!error){
                CTGoodsModel *model = [CTGoodsModel yy_modelWithDictionary:data];
                _viewModel.model.iv_code = model.iv_code;
                _viewModel.model.order_url = model.order_url;
                _viewModel.model.qr_create_url = model.qr_create_url;
                self.descView.viewModel = _viewModel;
            }
        }];
    }
    else if(_kind == CTShopPdd){
        [CTRequest goodsShareWithId:self.goodId kind:_kind callback:^(id data, CLRequest *request, CTNetError error) {
            if(!error){
                CTGoodsModel *model = [CTGoodsModel yy_modelWithDictionary:data];
                _viewModel.model.iv_code = model.iv_code;
                _viewModel.model.order_url = model.order_url;
                _viewModel.model.qr_create_url = model.qr_create_url;
                self.descView.viewModel = _viewModel;
            }
        }];
    }
   
}

@end
