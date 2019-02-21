//
//  CTPhotoView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/30.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTPhotoView : UIView

@property (nonatomic, copy) NSArray <NSString *>*imgs;

@property (nonatomic, assign)BOOL isCanEdit;

@property (nonatomic, assign) NSUInteger maxCount;

@property (nonatomic, assign) NSUInteger rowCount;

@property (nonatomic, assign) NSUInteger space;

@property (nonatomic, assign) BOOL autoExtrusion;

@end
