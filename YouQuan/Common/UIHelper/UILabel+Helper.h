//
//  UILabel+Helper.h
//  
//
//  Created by dengchenglin on 2018/9/20.
//

#import <UIKit/UIKit.h>

@interface UILabel (Helper)

- (void)addActionWithBlock:(void(^)(id target))block;

@end
