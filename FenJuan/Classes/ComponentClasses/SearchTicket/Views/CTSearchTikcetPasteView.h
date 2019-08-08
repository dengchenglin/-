//
//  CTSearchTikcetPasteView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/25.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTButton.h"

@interface CTSearchTikcetPasteView : UIView
@property (nonatomic, assign) NSInteger nishuocuole;
@property (nonatomic, strong) UIImageView *sharePotifter;
@property (nonatomic, strong) UIButton *hepercf;
@property (nonatomic, strong) UIView *haodade;

@property (weak, nonatomic) IBOutlet UIView *navBarView;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) void (^searchBlock)(NSString *keyword);
@end
