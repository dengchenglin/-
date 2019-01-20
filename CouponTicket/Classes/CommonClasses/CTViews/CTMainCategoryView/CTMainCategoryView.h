//
//  CTMainCategoryView.h
//  CouponTicket
//
//  Created by Dankal on 2019/1/20.
//  Copyright © 2019 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTCategoryModel.h"


#define CTMainCategoryHeadViewHeight 44

@interface CTMainCategoryHeadView :UIView
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@interface CTMainCategoryItem:UIView

@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@interface CTMainCategoryView : UIView

@property (nonatomic, copy) NSArray <CTCategoryModel *> *categoryModels;
- (void)show;
- (void)hide;

@end
