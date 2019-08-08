//
//  CTSearchViewController.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import "CTBaseViewController.h"

#import "CTSearchPreviewView.h"

@interface CTSearchViewController : CTBaseViewController
@property (nonatomic, assign) NSInteger nishuocuole;
@property (nonatomic, strong) UIImageView *sharePotifter;
@property (nonatomic, strong) UIButton *hepercf;
@property (nonatomic, strong) UIView *haodade;

@property (nonatomic, strong) UITableView *dataTableView;

@property (nonatomic, strong) CTSearchPreviewView *previewView;


- (NSString *)keyword;

- (void)searchKeyword:(NSString *)keyword;

@end
