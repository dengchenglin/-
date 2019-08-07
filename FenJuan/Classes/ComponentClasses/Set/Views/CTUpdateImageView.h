//
//  CTUpdateImageView.h
//  CouponTicket
//
//  Created by dengchenglin on 2019/1/30.
//  Copyright © 2019年 Danke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTPhotoView.h"
@interface CTUpdateImageView : UIView
@property (weak, nonatomic) IBOutlet UILabel *countDescLabel;

@property (weak, nonatomic) IBOutlet CTPhotoView *photosView;

@end
