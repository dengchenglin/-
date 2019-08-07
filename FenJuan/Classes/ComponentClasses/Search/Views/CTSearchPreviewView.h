//
//  CTSearchPreviewView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/22.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTSearchPreviewView : UIView

@property (nonatomic, copy) NSArray <NSString *> *hotKeywords;

@property (nonatomic, copy) NSArray <NSString *> *historyKeywords;

@property (nonatomic, copy)void (^selectKeyBlock)(NSString *key);

@property (nonatomic, copy)void (^clearHistoryBlock)(void);


@end
