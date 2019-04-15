//
//  NSString+Category.m
//  GeihuiDemo
//
//  Created by peikua on 17/3/23.
//  Copyright © 2017年 peikua. All rights reserved.
//

#import "NSString+Category.h"

#import <CommonCrypto/CommonHMAC.h>

#import "RegalurUtil.h"

@implementation NSString (Category)

- (id)jsonValueDecoded {
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    if (error) {
        NSLog(@"jsonValueDecoded error:%@", error);
    }
    return value;
}

- (NSString *)md5FromString
{
    if([self length] == 0){
        return nil;
    }
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    NSMutableString *md5String = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [md5String appendFormat:@"%02x",outputBuffer[count]];
    }
    return md5String;
}

- (BOOL)roughValidateMobile{
    if(!self.length)return NO;
     return [RegalurUtil isMatchString:self withRule:@"^[1][3,4,5,7,8][0-9]{9}$"];
}

- (BOOL)validateMobile{
    if(!self.length)return NO;
   return [RegalurUtil isMatchString:self withRule:@"^[1](([3][0-9])|([4][5-9])|([5][0-3,5-9])|([6][5,6])|([7][0-8])|([8][0-9])|([9][1,8,9]))[0-9]{8}$"];
}

- (BOOL)validateEmail{
    return [RegalurUtil isMatchString:self withRule:@"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

- (BOOL)validateBankCard{
    NSString *bankCard = self.copy;
    if (bankCard.length < 16) {
        return NO;
    }
    NSInteger oddsum = 0;     //奇数求和
    NSInteger evensum = 0;    //偶数求和
    NSInteger allsum = 0;
    NSInteger cardNoLength = (NSInteger)[bankCard length];
    // 取了最后一位数
    NSInteger lastNum = [[bankCard substringFromIndex:cardNoLength-1] intValue];
    //测试的是除了最后一位数外的其他数字
    bankCard = [bankCard substringToIndex:cardNoLength - 1];
    for (NSInteger i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [bankCard substringWithRange:NSMakeRange(i-1, 1)];
        NSInteger tmpVal = [tmpString integerValue];
        if (cardNoLength % 2 ==1 ) {//卡号位数为奇数
            if((i % 2) == 0){//偶数位置
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{//奇数位置
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;

}
- (BOOL)validateIdentityCard{
    NSString *value = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (!value) {
        return NO;
    } else {
        length = value.length;
        //不满足15位和18位，即身份证错误
        if (length != 15 && length != 18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    // 检测省份身份行政区代码
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO; //标识省份代码是否正确
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year = 0;
    //分为15位、18位身份证进行校验
    switch (length) {
        case 15:
            //获取年份对应的数字
            year = [value substringWithRange:NSMakeRange(6, 2)].intValue + 1900;
            if (year %4 == 0 || (year %100 == 0 && year %4 == 0)) {
                //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];
            } else {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"options:NSRegularExpressionCaseInsensitive error:nil];
            }
            //使用正则表达式匹配字符串 NSMatchingReportProgress:找到最长的匹配字符串后调用block回调
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if (numberofMatch > 0) {
                return YES;
            } else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6, 4)].intValue;
            if (year %4 == 0 || (year %100 == 0 && year %4 == 0)) {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];
            } else {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            
            if (numberofMatch > 0) {
                //1：校验码的计算方法 身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。将这17位数字和系数相乘的结果相加。
                int S = [value substringWithRange:NSMakeRange(0, 1)].intValue * 7 + [value substringWithRange:NSMakeRange(10, 1)].intValue * 7 + [value substringWithRange:NSMakeRange(1, 1)].intValue * 9 + [value substringWithRange:NSMakeRange(11, 1)].intValue * 9 + [value substringWithRange:NSMakeRange(2, 1)].intValue * 10 + [value substringWithRange:NSMakeRange(12, 1)].intValue * 10 + [value substringWithRange:NSMakeRange(3, 1)].intValue * 5 + [value substringWithRange:NSMakeRange(13, 1)].intValue * 5 + [value substringWithRange:NSMakeRange(4, 1)].intValue * 8 + [value substringWithRange:NSMakeRange(14, 1)].intValue * 8 + [value substringWithRange:NSMakeRange(5, 1)].intValue * 4 + [value substringWithRange:NSMakeRange(15,1)].intValue * 4 + [value substringWithRange:NSMakeRange(6, 1)].intValue * 2 + [value substringWithRange:NSMakeRange(16, 1)].intValue * 2 + [value substringWithRange:NSMakeRange(7, 1)].intValue * 1 + [value substringWithRange:NSMakeRange(8, 1)].intValue * 6 + [value substringWithRange:NSMakeRange(9, 1)].intValue * 3;
                //2：用加出来和除以11，看余数是多少？余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字
                int Y = S %11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                //3：获取校验位
                M = [JYM substringWithRange:NSMakeRange(Y, 1)];
                NSString *lastStr = [value substringWithRange:NSMakeRange(17, 1)];
               
                //4：检测ID的校验位
                if ([lastStr isEqualToString:@"x"]) {
                    if ([M isEqualToString:@"X"]) {
                        return YES;
                    } else {
                        return NO;
                    }
                } else {
                    if ([M isEqualToString:[value substringWithRange:NSMakeRange(17, 1)]]) {
                        return YES;
                    } else {
                        return NO;
                    }
                }
            } else {
                return NO;
            }
        default:
            return NO;
    }

}

- (NSString *)wipSpace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (CGSize)sizeWithFont:(UIFont*)font  maxSize:(CGSize)size {
 
    NSDictionary*attrs =@{NSFontAttributeName: font};

    return  [self  boundingRectWithSize:size  options:NSStringDrawingUsesLineFragmentOrigin  attributes:attrs   context:nil].size;
}


@end
