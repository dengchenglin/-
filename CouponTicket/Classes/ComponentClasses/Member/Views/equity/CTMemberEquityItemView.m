//
//  CTMemberEquityItemView.m
//  CouponTicket
//
//  Created by dengchenglin on 2019/3/21.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTMemberEquityItemView.h"
#import "CTMemberEquityRowView.h"
@interface CTMemberEquityItemView()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerHeight;

@end

@implementation CTMemberEquityItemView

- (void)setDatas:(NSArray<CTMemberRebateModel *> *)datas{
    _datas = datas;
    [self.containerView removeAllSubViews];
    
    UIView *topView;
    for(int i = 0;i < datas.count;i ++){
        CTMemberRebateModel *model = datas[i];
        CTMemberEquityRowView *rowView = NSMainBundleClass(CTMemberEquityRowView.class);
        rowView.titleLabel.text = model.fx_level;
        rowView.valueLabel.text = model.fx_scale;
        [self.containerView addSubview:rowView];
        [rowView mas_makeConstraints:^(MASConstraintMaker *make) {
            if(topView){
                make.top.mas_equalTo(topView.mas_bottom).offset(20);
                
            }
            else{
                make.top.mas_equalTo(0);
            }
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(20);
        }];
        topView = rowView;
    }
    _containerHeight.constant =  20 + datas.count * 40;

    [self layoutIfNeeded];
}

@end
