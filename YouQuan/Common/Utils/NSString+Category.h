//
//  NSString+Category.h
//  GeihuiDemo
//
//  Created by peikua on 17/3/23.
//  Copyright © 2017年 peikua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

/**
 * json解析
 */
- (id)jsonValueDecoded;

/**
 * md5加密
 */
- (NSString *)md5FromString;

/**
 * 粗略手机号格式验证
 */
- (BOOL)roughValidateMobile;

/**
 * 精确手机号格式验证
 */
- (BOOL)validateMobile;
/**
 * 邮箱格式验证
 */
- (BOOL)validateEmail;
/**
 * 身份证验证
 */
- (BOOL)validateIdentityCard;
/**
 * 银行卡验证
 */
- (BOOL)validateBankCard;
/**
 * 去除首位空格
 */
- (NSString *)wipSpace;

//普通算高
- (CGSize)sizeWithFont:(UIFont*)font  maxSize:(CGSize)size;

@end
