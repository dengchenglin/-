//
//  CTSharePopContainerView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/2/15.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTSharePopContainerView.h"

#import "CTShareItemView.h"


struct CTShareType {
    __unsafe_unretained NSString *shareType;
    __unsafe_unretained NSString *shareTitle;
    __unsafe_unretained NSString *shareImg;
};

struct CTShareType infos[] = {
    {CTShareTypeWeChat,@"微信",@"ic_wechat"},
    {CTShareTypeQQ,@"QQ",@"ic_qq"},
    {CTShareTypeSaveImg,@"保存图片",@"ic_photo"}
};

NSString *GetImageStr(NSString *shareType){
    for(int i = 0;i < sizeof(infos)/sizeof(infos[0]);i ++){
        if([shareType isEqualToString:infos[i].shareType]){
            return infos[i].shareImg;
        }
    }
    return @"";
}
NSString *GetTitleStr(NSString *shareType){
    for(int i = 0;i < sizeof(infos)/sizeof(infos[0]);i ++){
        if([shareType isEqualToString:infos[i].shareType]){
            return infos[i].shareTitle;
        }
    }
    return @"";
}

static CGFloat itemHeight = 100;

static CGFloat itemContinerHeight = 78;

@implementation CTSharePopContainerView

+ (CGFloat)heightForItemCount:(NSInteger)index{
    return (index + 2)/3 * itemHeight - (itemHeight - itemContinerHeight);
}

- (void)setShareTypes:(NSArray<NSString *> *)shareTypes{
    _shareTypes = shareTypes;

    [self reloadView];
}
- (void)reloadView{
    [self.containerView removeAllSubViews];
    CGFloat containerHeight = [self.class heightForItemCount:_shareTypes.count];
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(containerHeight);
    }];

    CGFloat itemWidth = SCREEN_WIDTH/3;

    for(int i = 0;i < _shareTypes.count;i ++){
        CTShareItemView *itemView = NSMainBundleClass(CTShareItemView.class);
        itemView.tag = 100 + i;
        itemView.iconImageView.image = [UIImage imageNamed:GetImageStr(_shareTypes[i])];
        itemView.titleLabel.text = GetTitleStr(_shareTypes[i]);
        [self.containerView addSubview:itemView];
        CGFloat left = (i%3) * itemWidth;
        CGFloat top = (i/3) * itemHeight;
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
            make.top.mas_equalTo(top);
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(itemContinerHeight);
        }];
        
        @weakify(self)
        [itemView addActionWithBlock:^(UIView *target) {
            @strongify(self)
            if(self.clickItemBlock){
                self.clickItemBlock(target.tag - 100);
            }
        }];
    }
}

@end
