//
//  CTGoodDetailViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodDetailViewController.h"

#import "CTGoodsImgsView.h"

#import "CTGoodsDescView.h"

#import "CTGoodsCouponView.h"

#import "CTGoodsBuyView.h"

#import "CTNetworkEngine+Goods.h"

#import "CTGoodsViewModel.h"

@interface CTGoodDetailViewController()

@property (nonatomic, strong) CTGoodsImgsView *imgsView;

@property (nonatomic, strong) CTGoodsDescView *descView;

@property (nonatomic, strong) CTGoodsCouponView *couponView;

@property (nonatomic, strong) CTGoodsBuyView *buyView;

@end

@implementation CTGoodDetailViewController

- (CTGoodsImgsView *)imgsView{
    if(!_imgsView){
        _imgsView = [[CTGoodsImgsView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    }
    return _imgsView;
}
- (CTGoodsDescView *)descView{
    if(!_descView){
        _descView = NSMainBundleClass(CTGoodsDescView.class);
    }
    return _descView;
}
- (CTGoodsCouponView *)couponView{
    if(!_couponView){
        _couponView = NSMainBundleClass(CTGoodsCouponView.class);
    }
    return _couponView;
}
- (CTGoodsBuyView *)buyView{
    if(!_buyView){
        _buyView = NSMainBundleClass(CTGoodsBuyView.class);
    }
    return _buyView;
}
- (void)setUpUI{
    self.title = @"商品详情";
    [self setRightButtonWithTitle:@"分享" font:CTPsbFont(14) titleColor:[UIColor whiteColor] selector:@selector(shareAction)];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.scrollViewAvailable = YES;
    [self.autoLayoutContainerView addSubview:self.imgsView];
    [self.autoLayoutContainerView addSubview:self.descView];
    [self.autoLayoutContainerView addSubview:self.couponView];
    [self.view addSubview:self.buyView];
}
- (void)autoLayout{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(45);
    }];
    [self.imgsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_WIDTH);
    }];
    [self.descView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgsView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(115);
    }];
    [self.couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(127);
        make.bottom.mas_equalTo(40);
    }];
    [self.buyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
}

- (void)reloadView{
    self.scrollView.hidden = YES;
    if(self.viewModel){
        self.scrollView.hidden = NO;
        self.imgsView.banner_imgs = _viewModel.model.goods_image;
        self.descView.viewModel = _viewModel;
        self.couponView.viewModel = _viewModel;
        self.buyView.viewModel = _viewModel;
    }
}

- (void)request{
    if(!self.goog_id.length){
        return;
    }
    [CTRequest goodsDetailWithId:self.goog_id callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
             self.viewModel = [CTGoodsViewModel bindModel:[CTGoodsModel yy_modelWithDictionary:data]];
            [self reloadView];
        }
    }];
}

- (void)setUpEvent{
    @weakify(self)
    //收藏
    void(^collectBlock)(void) = ^{
         @strongify(self);
        [CTRequest favoriteWithGoodsId:self.viewModel.model.item_id isFavorite:!self.viewModel.model.is_favorite callback:^(id data, CLRequest *request, CTNetError error) {
            @strongify(self);
            if(!error){
                self.viewModel.model.is_favorite = !self.viewModel.model.is_favorite;
                self.buyView.viewModel = self.viewModel;
            }
        }];
    };
    
    [self.buyView.collectButton touchUpInsideSubscribeNext:^(id x) {
        if([CTAppManager logined]){
            collectBlock();
        }
        else{
            [[CTModuleManager loginService]showLoginFromViewController:self success:^{
                collectBlock();
            } failure:nil];
        }
    }];
    
    //买买买
    void (^buybuy)(void) = ^{
        @strongify(self)
        //获取真正的click_url
        [AliTradeManager autoWithViewController:self successCallback:^(ALBBSession *session) {
            @strongify(self)
            [CTRequest goodsUrlConvertWithTbGoodUrl:self.viewModel.model.coupon_share_url tbCode:[session getUser].topAuthCode tbToken:[session getUser].topAccessToken callback:^(id data, CLRequest *request, CTNetError error) {
                @strongify(self)
                if(!error){
                    NSString *clickUrl = data;
                    //[[CTModuleManager webService]pushWebFromViewController:self url:clickUrl];
                    [AliTradeManager openTbWithViewController:self url:clickUrl];
                }
                else{
                    NSString *clickUrl = data[@"data"];
                    [[CTModuleManager webService]pushWebFromViewController:self url:clickUrl];
                    //[AliTradeManager openTbWithViewController:self url:clickUrl];
                }
            }];
        }];
    };
    
    void (^clickButtonBlock)(void) = ^{
        @strongify(self)
        if([CTAppManager logined]){
            buybuy();
        }
        else {
            [[CTModuleManager loginService]showLoginFromViewController:self callback:^(BOOL logined) {
                if(logined){
                    buybuy();
                }
            }];
        }
    };
    
    [self.buyView.buyButton touchUpInsideSubscribeNext:^(id x) {
        clickButtonBlock();
    }];
    [self.couponView addActionWithBlock:^(id target) {
        clickButtonBlock();
    }];
}

- (void)shareAction{
    
}

@end
