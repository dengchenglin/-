//
//  CTGoodsPreViewController.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/23.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTGoodsPreViewController.h"
#import "CTGoodsImgsView.h"
#import "CTGoodsDescPreView.h"
#import "CTSharePopView.h"
#import "UIView+YYAdd.h"
@interface CTGoodsPreViewController ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) CTGoodsImgsView *imgsView;
@property (nonatomic, strong) CTGoodsDescPreView *descView;
@property (nonatomic, strong) CTGoodsViewModel *viewModel;
@property (nonatomic, copy) NSString *qCodeContent;
@end

@implementation CTGoodsPreViewController

+ (CTGoodsPreViewController *)pushGoodPreFromViewController:(UIViewController *)viewController viewModel:(CTGoodsViewModel *)viewModel qCodeContent:(NSString *)qCodeContent{
    CTGoodsPreViewController *vc = [CTGoodsPreViewController new];
    vc.viewModel = viewModel;
    vc.qCodeContent = qCodeContent;
    [viewController.navigationController pushViewController:vc animated:YES];
    return vc;
}
- (UIView *)containerView{
    if(!_containerView){
        _containerView = [UIView new];
    }
    return _containerView;
}
- (CTGoodsImgsView *)imgsView{
    if(!_imgsView){
        _imgsView = [[CTGoodsImgsView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    }
    return _imgsView;
}
- (CTGoodsDescPreView *)descView{
    if(!_descView){
        _descView = NSMainBundleClass(CTGoodsDescPreView.class);
    }
    return _descView;
}

- (void)setUpUI{
    self.title = @"图片预览";
    self.view.backgroundColor = [UIColor blackColor];
    [self setRightButtonWithTitle:@"分享" font:CTPsbFont(16) titleColor:[UIColor whiteColor] selector:@selector(shareAction)];
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.imgsView];
    [self.containerView addSubview:self.descView];
}
- (void)autoLayout{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
    [self.imgsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(SCREEN_WIDTH);
    }];
    [self.descView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgsView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(147);
        make.bottom.mas_equalTo(0);
    }];
}
- (void)reloadView{
    if(_viewModel){
        self.descView.viewModel = _viewModel;
        self.imgsView.banner_imgs = _viewModel.model.goods_image;
        if(_qCodeContent.length){
            void(^setQcodeImageBlock)(UIImage *) = ^(UIImage *centerImage){
                UIImage *qCodeImage = [UIUtil createQRCodeImageWithString:self.qCodeContent andSize:CGSizeMake(200, 200) andBackColor:[UIColor whiteColor] andFrontColor:[UIColor blackColor] andCenterImage:centerImage];
                self.descView.qCodeImageView.image = qCodeImage;
            };
            if([CTAppManager user].headimg.length){
                [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:[CTAppManager user].headimg] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                    setQcodeImageBlock(image);
                }];
            }
            else{
                setQcodeImageBlock(nil);
            }
        }

    }
}
- (void)shareAction{
    UIImage *image = [self.view snapshotImage];
    if(!image){
        [MBProgressHUD showMBProgressHudWithTitle:@"图片出错"];
        return;
    }
    [CTSharePopView showSharePopViewWithTypes:@[CTShareTypeWeChat,CTShareTypeQQ,CTShareTypeSaveImg] image:image imageUrl:nil title:nil url:nil];
}
@end
