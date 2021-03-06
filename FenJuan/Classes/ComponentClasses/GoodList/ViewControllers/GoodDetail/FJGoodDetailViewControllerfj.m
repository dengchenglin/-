//
//  CTGoodDetailViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/24.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "FJGoodDetailViewControllerfj.h"
#import "FJGoodsImgsViewfj.h"
#import "FJGoodsDescViewfj.h"
#import "FJGoodsCouponViewfj.h"
#import "FJGoodsBuyViewfj.h"
#import "CTNetworkEngine+Goods.h"
#import "CTGoodsViewModel.h"
#import "FJGoodsPreViewControllerfj.h"
#import "CTGoodDetailNavbar.h"
#import "CTSharePopView.h"
#import "FJGoodsContentViewfj.h"
#import "FJGoodsImgsHeadViewfj.h"
#import "FJGoodsImgCellfj.h"
@interface CTGoodsTableView:UITableView
@property (nonatomic, assign) BOOL scrollViewAllowMultiGes;
@end
@implementation CTGoodsTableView
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if(_scrollViewAllowMultiGes){
       return YES;
    }
    return NO;
}

@end
@interface FJGoodDetailViewControllerfj()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) CTGoodsTableView *tableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) CTGoodDetailNavbar *navBar;
@property (nonatomic, strong) FJGoodsImgsViewfj *imgsView;
@property (nonatomic, strong) FJGoodsDescViewfj *descView;
@property (nonatomic, strong) FJGoodsCouponViewfj *couponView;
@property (nonatomic, strong) FJGoodsContentViewfj *contentView;
@property (nonatomic, strong) FJGoodsBuyViewfj *buyView;
@property (nonatomic, strong) FJGoodsImgsHeadViewfj *imgsHeadView;
@property (nonatomic, copy) NSArray <CTGoodsImgModel *> *imgs;

@end

@implementation FJGoodDetailViewControllerfj

- (CTGoodsTableView *)tableView{
    if(!_tableView){
        _tableView = [[CTGoodsTableView alloc]initWithFrame:CGRectZero  style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass(FJGoodsImgCellfj.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(FJGoodsImgCellfj.class)];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } 
    }
    return _tableView;
}

- (CTGoodDetailNavbar *)navBar{
    if(!_navBar){
        _navBar = NSMainBundleClass(CTGoodDetailNavbar.class);
    }
    return _navBar;
}

- (FJGoodsImgsViewfj *)imgsView{
    if(!_imgsView){
        _imgsView = [[FJGoodsImgsViewfj alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    }
    return _imgsView;
}
- (FJGoodsDescViewfj *)descView{
    if(!_descView){
        _descView = NSMainBundleClass(FJGoodsDescViewfj.class);
    }
    return _descView;
}
- (FJGoodsCouponViewfj *)couponView{
    if(!_couponView){
        _couponView = NSMainBundleClass(FJGoodsCouponViewfj.class);
    }
    return _couponView;
}
- (FJGoodsContentViewfj *)contentView{
    if(!_contentView){
        _contentView = NSMainBundleClass(FJGoodsContentViewfj.class);
    }
    return _contentView;
}
- (FJGoodsBuyViewfj *)buyView{
    if(!_buyView){
        _buyView = NSMainBundleClass(FJGoodsBuyViewfj.class);
    }
    return _buyView;
}
- (FJGoodsImgsHeadViewfj *)imgsHeadView{
    if(!_imgsHeadView){
        _imgsHeadView = NSMainBundleClass(FJGoodsImgsHeadViewfj.class);
    }
    return _imgsHeadView;
}

- (UIView *)headView{
    if(!_headView){
        _headView = [UIView new];
        [_headView addSubview:self.imgsView];
        [_headView addSubview:self.descView];
        [_headView addSubview:self.couponView];
        [_headView addSubview:self.contentView];
    }
    return _headView;
}
- (void)setUpUI{
    self.title = @"商品详情";
    self.hideSystemNavBarWhenAppear = YES;
    self.tableView.backgroundColor = CTBackGroundGrayColor;
    [self.view addSubview:self.tableView];
    self.contentView.contentView.scrollView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.buyView];
    [self.view addSubview:self.navBar];
    [self.headView class];
}


- (void)autoLayout{
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(NAVBAR_HEIGHT);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.buyView.mas_top);
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
        make.top.mas_equalTo(self.couponView.mas_bottom).offset(7);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.buyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(45 + BOTTOM_HEIGHT);
    }];
    @weakify(self)
    [self.contentView setHeightChangeBlock:^(CGFloat height) {
        @strongify(self)
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.imgs.count?2:1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 0;
    }
    return self.imgs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        CGSize size = [self.headView systemLayoutSizeFittingSize:CGSizeMake(SCREEN_WIDTH, 3000)];
        return size.height;
    }
    return 45;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return self.headView;
    }
    return self.imgsHeadView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CTGoodsImgModel *model = self.imgs[indexPath.row];
    CGSize size = [model.size CGSizeValue];
    return [FJGoodsImgCellfj heightForImgSize:size];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FJGoodsImgCellfj *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(FJGoodsImgCellfj.class)];
    CTGoodsImgModel *model = self.imgs[indexPath.row];
    [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:model.img] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [model checkAndAmendWithRealSize:image.size];
        if(!model.checked){
            [tableView reloadData];
        }
    }];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView == self.tableView){
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
}

- (void)reloadView{
    self.tableView.hidden = YES;
    if(self.viewModel){
        self.tableView.hidden = NO;
        self.imgsView.banner_imgs = _viewModel.model.goods_image;
        self.descView.viewModel = _viewModel;
        self.couponView.viewModel = _viewModel;
        self.buyView.viewModel = _viewModel;
        self.contentView.htmlString = self.viewModel.model.goods_content;
        if(self.viewModel.model.goods_content.length){
            self.tableView.scrollViewAllowMultiGes = YES;
            self.contentView.hidden = NO;
        }
        else{
            self.contentView.hidden = YES;
            self.tableView.scrollViewAllowMultiGes = NO;
        }
        [self.couponView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.viewModel.model.show_coupon?127:0);
        }];
    }
}

- (void)request{
    if(!self.goog_id.length){
        [self requestGoodsImg];
        return;
    }
    [CTRequest goodsDetailWithId:self.goog_id callback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
             self.viewModel = [CTGoodsViewModel bindModel:[CTGoodsModel yy_modelWithDictionary:data]];
            [self reloadView];
            [self requestGoodsImg];
        }
    }];
}

- (void)requestGoodsImg{
    if(self.viewModel.model.goods_rich_url.length && !self.viewModel.model.goods_content.length){
        [CTRequest fj_goodsImgWithItemId:self.viewModel.model.item_id callback:^(id data, CLRequest *request, CTNetError error) {
            self.imgs = [CTGoodsImgModel modelsWithDatas:data];
            [self.tableView reloadData];
        }];
    }
}

- (void)setUpEvent{
    @weakify(self)

    //收藏
    void(^collectBlock)(void) = ^{
         @strongify(self);
        self.buyView.collectButton.userInteractionEnabled = NO;
        [CTRequest fj_favoriteWithGoodsId:self.viewModel.model.item_id isFavorite:!self.viewModel.model.is_favorite callback:^(id data, CLRequest *request, CTNetError error) {
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
        [CTRequest fj_goodsUrlConvertWithTbGoodsInfo:params callback:^(id data, CLRequest *request, CTNetError error) {
            @strongify(self)
            if(!error){//绑定过渠道id 直接返回最终数据
                //先百川授权
                [AliTradeManager autoWithViewController:self successCallback:^(ALBBSession *session) {
                    if(getFinalData){
                        getFinalData(data);
                    }
                }];
                
            }
            else{//如果未绑定过渠道id 需要先进行淘宝h5授权  h5授权成功后js返回数据与绑定成功后的数据一样
                NSInteger status = [data[@"status"] integerValue];
                if(status == 403){
                    NSString *tbAuthUrl = data[@"data"];
                    [[CTModuleManager webService]fj_tbAuthFromViewController:self url:tbAuthUrl callback:^(id data) {
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

    //下单 唤起手淘
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
            [[CTModuleManager loginService]fj_showLoginFromViewController:self callback:^(BOOL logined) {
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
    void(^toShareBlock)(void) = ^{
        [CTModuleHelper shareShopFromViewController:self viewModel:self.viewModel];
    };
    [self.navBar.shareButton touchUpInsideSubscribeNext:^(id x) {
        toShareBlock();
    }];
    //分享
    [self.buyView.awardView addActionWithBlock:^(id target) {
        toShareBlock();
    }];
    //点击返回
    [self.navBar.backButton touchUpInsideSubscribeNext:^(id x) {
        @strongify(self)
        [self back];
    }];

}



- (void)dealloc
{
    self.contentView.contentView.scrollView.delegate = nil;
    self.contentView.contentView.delegate = nil;
}
@end
