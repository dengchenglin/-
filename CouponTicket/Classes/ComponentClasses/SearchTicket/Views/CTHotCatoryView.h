//
//  CTHotCatoryView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTMainCategoryView.h"

@interface CTHotCatoryView : UIView
@property (weak, nonatomic) IBOutlet UIView *titleheadView;
@property (weak, nonatomic) IBOutlet CTMainCategoryView *categoryView;
@property (nonatomic, copy) NSArray <CTCategoryModel *> *categoryModels;
@end
