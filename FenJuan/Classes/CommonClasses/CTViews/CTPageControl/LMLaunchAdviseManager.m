//
//  LMLaunchAdviseManager.m
//  LightMaster
//
//  Created by dengchenglin on 2019/1/9.
//  Copyright © 2019年 Qianmeng. All rights reserved.
//

#import "LMLaunchAdviseManager.h"

#import "LMPageControl.h"

#import <SDWebImage/SDImageCache.h>

#import "CTNetworkEngine+Common.h"


@interface LaunchPic:NSObject

@property (nonatomic, copy) NSString *pic_id;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) CGFloat weight;

@end

@implementation LaunchPic

@end

@interface LMLaunchAdviseView:UIView<LMPageControlDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *timerLabel;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) LMPageControl *pageControl;

@property (nonatomic, copy) NSArray <UIImage *> *images;

+ (void)showLaunchAdviseViewWithImages:(NSArray <UIImage *>*)images completed:(void(^)(void))completed;

@end


@implementation LMLaunchAdviseView
{
    NSTimer *_timer;
}
+ (void)showLaunchAdviseViewWithImages:(NSArray <UIImage *>*)images completed:(void(^)(void))completed{
    LMLaunchAdviseView *adviseView = [[LMLaunchAdviseView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    adviseView.images = images;
    [[UIApplication sharedApplication].keyWindow addSubview:adviseView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _timerLabel = [[UILabel alloc]init];
    _timerLabel.backgroundColor = RGBAColor(10, 10, 10, 0.15);
    _timerLabel.textColor = [UIColor whiteColor];
    _timerLabel.textAlignment = NSTextAlignmentCenter;
    _timerLabel.font = [UIFont systemFontOfSize:12];
    _timerLabel.layer.cornerRadius = 4;
    _timerLabel.text = @"3s";
    [self addSubview:_timerLabel];
    
    
    _pageControl = [[LMPageControl alloc]initWithFrame:CGRectMake(0, self.height - 40, self.width, 20)];
    [_pageControl setConfigInfo:^(LMPageControlInfo *info) {
        info.elementNormalImage = [UIImage imageNamed:@"pic_iu_normal"];
        info.elementSelectedImage = [UIImage imageNamed:@"pic_iu_selected"];
    }];
    _pageControl.delegate = self;
    [self addSubview:_pageControl];
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setTitle:@"跳过" forState:UIControlStateNormal];
    _closeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _closeButton.layer.cornerRadius = 4;
    _closeButton.backgroundColor = RGBAColor(10, 10, 10, 0.15);
    [self addSubview:_closeButton];
    [_closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
   
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _scrollView.frame = self.bounds;
    _timerLabel.size = CGSizeMake(50, 20);
    _timerLabel.center= CGPointMake(self.width - 70, 50);
    
    _closeButton.size = CGSizeMake(70, 30);
    _closeButton.center = CGPointMake(self.width - 70, self.height - 70);
}

- (void)setImages:(NSArray<UIImage *> *)images{
    _images = images;
    [_scrollView removeAllSubViews];
    for(int i = 0;i < _images.count;i ++){
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * self.width, 0, self.width, self.height)];
        //imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = _images[i];
        [_scrollView addSubview:imageView];
    }
    _scrollView.contentSize = CGSizeMake(_images.count * self.width, self.height);
    _pageControl.pageNumber = _images.count;
    
    
    if([_timer isValid]){
        [_timer invalidate];
        _timer = nil;
    }
    __block int time = 3;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.1 block:^(NSTimer *timer) {
        time --;
        if(time < 1){
            [self close];
        }
        else{
             self.timerLabel.text = [NSString stringWithFormat:@"%ds",time];
        }
    } repeats:YES];
}
- (void)close{
    if([_timer isValid]){
        [_timer invalidate];
        _timer = nil;
    }
    [self hide];
}

- (void)hide{
    [UIView animateWithDuration:1.0 animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentIndex = scrollView.contentOffset.x/self.width;
    [_pageControl scrollToIndex:currentIndex];
}

@end

@implementation LMLaunchAdviseManager


+ (void)showLaunchAdvise{
   
    NSArray *launching_pics = [self getLaunchPicAndCaches];
    if(!launching_pics.count)return;
    NSArray <LaunchPic *> *models = [LaunchPic yy_modelsWithDatas:launching_pics];
    BOOL result = YES;
    NSMutableArray *images = [NSMutableArray array];
    for(LaunchPic *pic in models){
        NSString *url = pic.image;
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
        if(image){
            [images addObject:image];
        }
        else{
            result = NO;
        }
        //该方法下载图片后会自动缓存到磁盘
        [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            NSLog(@"%@",image);
            [[SDImageCache sharedImageCache]storeImage:image forKey:url completion:nil];
        }];

    }
    if(result){
        [LMLaunchAdviseView showLaunchAdviseViewWithImages:[images copy] completed:^{
         
        }];
    }

    
}

+ (NSArray <NSString *>*)getLaunchPicAndCaches{
    //获取启动页数据
    [CTRequest appFunctionIoWithCallback:^(id data, CLRequest *request, CTNetError error) {
        if(!error){
            CTAppFunctionIo *io = [CTAppFunctionIo yy_modelWithDictionary:data];

            if(io.app_start_banner_io){
                NSArray *arr = @[@{@"image":io.app_start_banner_img}];
                [[NSUserDefaults standardUserDefaults] setValue:arr forKey:@"ct_launch_advise_key"];
            }
            else{
                [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"ct_launch_advise_key"];
            }
        }
    }];
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"ct_launch_advise_key"];
}

@end
