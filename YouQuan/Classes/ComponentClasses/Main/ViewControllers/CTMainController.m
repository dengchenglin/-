//
//  CTMainController.m
//  CouponTicket
//
//  Created by dencthenglin on 2019/1/18.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMainController.h"

#import "CTNavigationController.h"

#import "CTTabBarItem.h"

#import "CTTabBarModel.h"

@interface CTMainController ()
@property (nonatomic,  copy) NSArray <CTTabBarModel *>*tabbar_models;

@property (nonatomic,strong) UIView *ct_tabBar;

@property (nonatomic,strong) NSArray <CTTabBarItem *>*tabBarItems;
@end

@implementation CTMainController

- (UIView *)ct_tabBar{
    if(!_ct_tabBar){
        [self.tabBar removeAllSubViews];
        _ct_tabBar = [[UIView alloc]initWithFrame:self.tabBar.bounds];
        _ct_tabBar.backgroundColor = [UIColor whiteColor];
        [self.tabBar addSubview:_ct_tabBar];
    }
    return _ct_tabBar;
}


- (NSArray *)tabbar_models{
    if(!_tabbar_models){
        
        _tabbar_models = [CTTabBarModel yy_modelsWithDatas:[self tabbar_plist]];
    }
    return _tabbar_models;
}

- (NSArray<CTTabBarItem *> *)tabBarItems{
    
    if(!_tabBarItems){
        
        NSMutableArray *tabBarItems = [NSMutableArray array];
        CGFloat width = SCREEN_WIDTH/self.tabbar_models.count;
        @weakify(self);
        [self.tabbar_models enumerateObjectsUsingBlock:^(CTTabBarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self);
            CTTabBarItem *tabBarItem = [[CTTabBarItem alloc]initWithFrame:CGRectMake(idx * width, 0, width, self.ct_tabBar.height)];
            tabBarItem.tag = 100 + idx;
            tabBarItem.image = [UIImage imageNamed:obj.tabbar_normal_image];
            tabBarItem.selectedImage = [UIImage imageNamed:obj.tabbar_selected_image];
            tabBarItem.title = obj.title;
            
            [tabBarItem addTapGestureRecognizerWithBlock:^(id sender) {
                @strongify(self);
                self.selectedIndex = ((CTTabBarItem *)sender).tag - 100;
                
            }];
            [self.ct_tabBar addSubview:tabBarItem];
            
            [tabBarItems addObject:tabBarItem];
        }];
        _tabBarItems = [tabBarItems copy];
        
    }
    return  _tabBarItems;
}

- (NSArray <UIViewController *>*)main_viewControllers{
    
    return [[self tabbar_models] map:^id(NSInteger index, CTTabBarModel* element) {
        id<CLModuleServiceProtocol> service = [CTModuleManager serviceForStr:element.service];
        UIViewController *rootVc = [service rootViewController];
        
        return [[CTNavigationController alloc]initWithRootViewController:rootVc];
    }];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    if(selectedIndex == 3){
        if(![CTAppManager logined]){
            [[CTModuleManager loginService] showLoginFromViewController:self callback:^(BOOL logined) {
                if(logined){
                    [self setSelectedIndex:selectedIndex];
                }
            }];
             return ;
        }
    }
    [super setSelectedIndex:selectedIndex];
    [self.tabBarItems enumerateObjectsUsingBlock:^(CTTabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.selected = (selectedIndex == idx);
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [CTAppManager sharedInstance].mainTab = self;
    self.viewControllers = [self main_viewControllers];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage imageWithColor:RGBColor(240, 240, 240)]];
    
    @weakify(self)
    [self.tabBar aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^{
        @strongify(self)
        [self removeSystemTabbar];
    } error:NULL];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self removeSystemTabbar];
    CGRect frame = self.tabBar.frame;
    frame.origin.y = self.view.frame.size.height - TABBAR_HEIGHT;
    self.tabBar.frame = frame;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
}
//彻底删除系统的tabbaritem
- (void)removeSystemTabbar{
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([NSStringFromClass([obj class]) isEqualToString:@"UITabBarButton"]){
            [obj removeFromSuperview];
        }
    }];
}


- (NSArray *)tabbar_plist{
   //@{@"tabbar_normal_image":@"ic_tab_vip",@"tabbar_selected_image":@"ic_tab_vip_highlight",@"title":@"会员中心",@"service":@"ct_member"},
    return @[@{@"tabbar_normal_image":@"ic_tab_home",@"tabbar_selected_image":@"ic_tab_home_highlight",@"title":@"首页",@"service":@"ct_home"},
             @{@"tabbar_normal_image":@"ic_tab_recommend",@"tabbar_selected_image":@"ic_tab_recommend_highlight",@"title":@"推荐",@"service":@"ct_recommend"},
             @{@"tabbar_normal_image":@"ic_tab_search",@"tabbar_selected_image":@"ic_tab_search_highlight",@"title":@"查券",@"service":@"ct_search_ticket"},
             
             @{@"tabbar_normal_image":@"ic_tab_my",@"tabbar_selected_image":@"ic_tab_my_highlight",@"title":@"我的",@"service":@"ct_mine"},
             ];
    
}


- (void)goHome{
    if(self.viewControllers.count){
        UIViewController *rootVc = self.viewControllers.firstObject;
        if([rootVc isKindOfClass:UINavigationController.class]){
            UINavigationController *nav = (UINavigationController *)rootVc;
            if(nav.viewControllers.count){
                [nav popToRootViewControllerAnimated:NO];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.selectedIndex = 0;
        });
    }
}


- (void)dealloc
{
    
}


@end
