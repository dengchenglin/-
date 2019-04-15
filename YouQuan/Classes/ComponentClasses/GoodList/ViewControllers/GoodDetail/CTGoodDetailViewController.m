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

#import "CTGoodsPreViewController.h"

#import "CTGoodDetailNavbar.h"

#import "CTSharePopView.h"

#import "CTGoodsContentView.h"

@interface CTGoodDetailViewController()<UIScrollViewDelegate>

@property (nonatomic, strong) CTGoodDetailNavbar *navBar;

@property (nonatomic, strong) CTGoodsImgsView *imgsView;

@property (nonatomic, strong) CTGoodsDescView *descView;

@property (nonatomic, strong) CTGoodsCouponView *couponView;

@property (nonatomic, strong) CTGoodsContentView *contentView;

@property (nonatomic, strong) CTGoodsBuyView *buyView;

@end

@implementation CTGoodDetailViewController

- (CTGoodDetailNavbar *)navBar{
    if(!_navBar){
        _navBar = NSMainBundleClass(CTGoodDetailNavbar.class);
    }
    return _navBar;
}

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
- (CTGoodsContentView *)contentView{
    if(!_contentView){
        _contentView = NSMainBundleClass(CTGoodsContentView.class);
    }
    return _contentView;
}
- (CTGoodsBuyView *)buyView{
    if(!_buyView){
        _buyView = NSMainBundleClass(CTGoodsBuyView.class);
    }
    return _buyView;
}
- (void)setUpUI{
    self.title = @"商品详情";
    self.hideSystemNavBarWhenAppear = YES;
    self.scrollViewAvailable = YES;
    self.scrollView.delegate = self;
    self.scrollViewAllowMultiGes = YES;
    self.scrollView.backgroundColor = CTBackGroundGrayColor;
    self.contentView.contentView.scrollView.delegate = self;
    [self.autoLayoutContainerView addSubview:self.imgsView];
    [self.autoLayoutContainerView addSubview:self.descView];
    [self.autoLayoutContainerView addSubview:self.couponView];
    [self.autoLayoutContainerView addSubview:self.contentView];
    [self.view addSubview:self.buyView];
    [self.view addSubview:self.navBar];
}


- (void)autoLayout{
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(NAVBAR_HEIGHT);
    }];
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-45-BOTTOM_HEIGHT);
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
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.couponView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
    [self.buyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(45 + BOTTOM_HEIGHT);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView == self.scrollView){
        CGFloat startOffest = SCREEN_WIDTH;
        CGFloat alpha = 0;
        if(scrollView.contentOffset.y > startOffest){
            alpha = (scrollView.contentOffset.y - startOffest)/80;
        }
        else{
            alpha = 0;
        }
        self.navBar.backgroundAlpha = alpha;
    }
    [self ges_scrollViewDidScroll:scrollView];
}

- (void)reloadView{
    self.scrollView.hidden = YES;
    if(self.viewModel){
        self.scrollView.hidden = NO;
        self.imgsView.banner_imgs = _viewModel.model.goods_image;
        self.descView.viewModel = _viewModel;
        self.couponView.viewModel = _viewModel;
        self.buyView.viewModel = _viewModel;
        if(_viewModel.model.goods_content.length){
            self.contentView.htmlString = _viewModel.model.goods_content;
        }
        else{
            self.contentView.url = _viewModel.model.goods_content_url;
        }
        [self.couponView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.viewModel.model.show_coupon?127:0);
        }];
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
        self.buyView.collectButton.userInteractionEnabled = NO;
        [CTRequest favoriteWithGoodsId:self.viewModel.model.item_id isFavorite:!self.viewModel.model.is_favorite callback:^(id data, CLRequest *request, CTNetError error) {
            @strongify(self);
            self.buyView.collectButton.userInteractionEnabled = YES;
            if(!error){
                self.viewModel.model.is_favorite = !self.viewModel.model.is_favorite;
                self.buyView.viewModel = self.viewModel;
                [MBProgressHUD showMBProgressHudWithTitle:self.viewModel.model.is_favorite?@"收藏成功":@"取消收藏"];
            }
        }];
    };

    //通过转链接口获取真正的click_url数据
    void (^goodsUrlConvertBlock)(void(^)(id data)) = ^(void(^getFinalData)(id data)){
        @strongify(self)
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValue:self.viewModel.model.goods_title forKey:@"goods_title"];
        [params setValue:self.viewModel.model.goods_logo forKey:@"goods_logo"];
        [params setValue:self.viewModel.model.coupon_share_url forKey:@"coupon_share_url"];
        //判断当前用户是否绑定过渠道id
        [CTRequest goodsUrlConvertWithTbGoodsInfo:params callback:^(id data, CLRequest *request, CTNetError error) {
            @strongify(self)
            if(!error){//绑定过渠道id 直接返回最终数据
                //先百川授权
                [AliTradeManager autoWithViewController:self successCallback:^(ALBBSession *session) {
                    if(getFinalData){
                        getFinalData(data);
                    }
                }];
            }
            else{//如果未绑定过渠道id 需要先进行淘宝授权
                NSInteger status = [data[@"status"] integerValue];
                if(status == 403){
                    NSString *tbAuthUrl = data[@"data"];
                    [[CTModuleManager webService]tbAuthFromViewController:self url:tbAuthUrl callback:^(id data) {
                        if(getFinalData){
                            getFinalData(data);
                        }
                    }];
                }
                else{
                    [MBProgressHUD showMBProgressHudWithTitle:data[@"info"]];
                }
            }
        }];
    };

    //下单最后一步 唤起手淘
    void (^goShop)(void) = ^{
        //先获取最终的数据
        goodsUrlConvertBlock(^(id data){
            @strongify(self)
            NSString *clickUrl = data[@"click_url"];
            [AliTradeManager openTbWithViewController:self url:clickUrl];
        });
    };
    
    //判断是否登录
    void (^judgeLoginBlock)(void(^)(void)) = ^(void(^loginCompleted)(void)){
        @strongify(self)
        if([CTAppManager logined]){
            if(loginCompleted){
                loginCompleted();
            }
        }
        else {
            [[CTModuleManager loginService]showLoginFromViewController:self callback:^(BOOL logined) {
                if(logined){
                    if(loginCompleted){
                        loginCompleted();
                    }
                }
            }];
        }
    };
    
    //点击收藏
    [self.buyView.collectButton touchUpInsideSubscribeNext:^(id x) {
        judgeLoginBlock(^{
            collectBlock();
        });
    }];
    
    //点击领券下单
    [self.buyView.buyButton touchUpInsideSubscribeNext:^(id x) {
        judgeLoginBlock(^{
            goShop();
        });
    }];
    //点击优惠券
    [self.couponView addActionWithBlock:^(id target) {
        judgeLoginBlock(^{
            goShop();
        });
    }];
    //点击分享
    [self.navBar.shareButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        judgeLoginBlock(^{
            goodsUrlConvertBlock(^(id data){
                @strongify(self)
                [CTGoodsPreViewController pushGoodPreFromViewController:self viewModel:self.viewModel qCodeContent:data[@"qcode_content"]];
            });
        });
    }];
    
    //点击返回
    [self.navBar.backButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [self back];
    }];

}


//解决与商品详情Web手势效果
static BOOL canMainScroll = YES;
static BOOL canChildScroll = NO;
- (void)initialize{
    canMainScroll = YES;
    canChildScroll = NO;
}
- (void)ges_scrollViewDidScroll:(UIScrollView *)scrollView{

    if(!self.contentView.titleHeight.constant)return;
    
    UIScrollView *mainScrollView = self.scrollView;
    UIScrollView *childScrollView = self.contentView.contentView.scrollView;
    
    CGFloat maxOffest = CGRectGetMinY(self.contentView.frame) + self.contentView.titleHeight.constant;
    
    if (scrollView == mainScrollView){
        if(!canMainScroll){
            mainScrollView.contentOffset = CGPointMake(0, maxOffest);
            canChildScroll = YES;
        }
        else if(scrollView.contentOffset.y >= maxOffest){
            mainScrollView.contentOffset = CGPointMake(0, maxOffest);
            canMainScroll = NO;
            canChildScroll = YES;
        }
    }
    else{
        if(!canChildScroll && childScrollView.isDragging){
            childScrollView.contentOffset = CGPointMake(-childScrollView.contentInset.left, -childScrollView.contentInset.top);
        }
        else if(scrollView.contentOffset.y <= -childScrollView.contentInset.top){
            canChildScroll = NO;
            canMainScroll = YES;
        }
    }
    
}



- (void)dealloc
{
    self.contentView.contentView.scrollView.delegate = nil;
    self.contentView.contentView.delegate = nil;
}
@end
