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

@implementation NSString (Emoji)

//编码
- (NSString *)emojiEncode{
    NSString *uniStr = [NSString stringWithUTF8String:[self UTF8String]];
    NSData *uniData = [uniStr dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *emojiText = [[NSString alloc] initWithData:uniData encoding:NSUTF8StringEncoding];
    return emojiText;
}

//解码
- (NSString *)emojiDecode{
    const char *jsonString = [self UTF8String];
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString *emojiText = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    return emojiText;
    
}
@end


static NSString * stringFromHTMLSymbol(NSString * s)
{
    if ([s hasPrefix:@"#"] && s.length <= 6) {
        
        unichar ch = (unichar)[[s substringFromIndex:1] integerValue];
        return [NSString stringWithFormat:@"%C", ch];
    }
    
    static NSDictionary *symbols;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //  This HTML symbols taken from DTFoundation
        //  https://github.com/Cocoanetics/DTFoundation
        //
        //  Created by Oliver Drobnik on 1/18/12.
        //  Copyright (c) 2012 Cocoanetics. All rights reserved.
        //
        
        /*
         Copyright (c) 2011, Oliver Drobnik All rights reserved.
         
         Redistribution and use in source and binary forms, with or without
         modification, are permitted provided that the following conditions are met:
         
         - Redistributions of source code must retain the above copyright notice, this
         list of conditions and the following disclaimer.
         
         - Redistributions in binary form must reproduce the above copyright notice,
         this list of conditions and the following disclaimer in the documentation
         and/or other materials provided with the distribution.
         
         THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
         AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
         IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
         DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
         FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
         DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
         SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
         CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
         OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
         OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
         */
        
        
        symbols = [[NSDictionary alloc] initWithObjectsAndKeys:
                   @"\x22", @"quot",
                   @"\x26", @"amp",
                   @"\x27", @"apos",
                   @"\x3c", @"lt",
                   @"\x3e", @"gt",
                   @"\u00a0", @"nbsp",
                   @"\u00a1", @"iexcl",
                   @"\u00a2", @"cent",
                   @"\u00a3", @"pound",
                   @"\u00a4", @"curren",
                   @"\u00a5", @"yen",
                   @"\u00a6", @"brvbar",
                   @"\u00a7", @"sect",
                   @"\u00a8", @"uml",
                   @"\u00a9", @"copy",
                   @"\u00aa", @"ordf",
                   @"\u00ab", @"laquo",
                   @"\u00ac", @"not",
                   @"\u00ae", @"reg",
                   @"\u00af", @"macr",
                   @"\u00b0", @"deg",
                   @"\u00b1", @"plusmn",
                   @"\u00b2", @"sup2",
                   @"\u00b3", @"sup3",
                   @"\u00b4", @"acute",
                   @"\u00b5", @"micro",
                   @"\u00b6", @"para",
                   @"\u00b7", @"middot",
                   @"\u00b8", @"cedil",
                   @"\u00b9", @"sup1",
                   @"\u00ba", @"ordm",
                   @"\u00bb", @"raquo",
                   @"\u00bc", @"frac14",
                   @"\u00bd", @"frac12",
                   @"\u00be", @"frac34",
                   @"\u00bf", @"iquest",
                   @"\u00c0", @"Agrave",
                   @"\u00c1", @"Aacute",
                   @"\u00c2", @"Acirc",
                   @"\u00c3", @"Atilde",
                   @"\u00c4", @"Auml",
                   @"\u00c5", @"Aring",
                   @"\u00c6", @"AElig",
                   @"\u00c7", @"Ccedil",
                   @"\u00c8", @"Egrave",
                   @"\u00c9", @"Eacute",
                   @"\u00ca", @"Ecirc",
                   @"\u00cb", @"Euml",
                   @"\u00cc", @"Igrave",
                   @"\u00cd", @"Iacute",
                   @"\u00ce", @"Icirc",
                   @"\u00cf", @"Iuml",
                   @"\u00d0", @"ETH",
                   @"\u00d1", @"Ntilde",
                   @"\u00d2", @"Ograve",
                   @"\u00d3", @"Oacute",
                   @"\u00d4", @"Ocirc",
                   @"\u00d5", @"Otilde",
                   @"\u00d6", @"Ouml",
                   @"\u00d7", @"times",
                   @"\u00d8", @"Oslash",
                   @"\u00d9", @"Ugrave",
                   @"\u00da", @"Uacute",
                   @"\u00db", @"Ucirc",
                   @"\u00dc", @"Uuml",
                   @"\u00dd", @"Yacute",
                   @"\u00de", @"THORN",
                   @"\u00df", @"szlig",
                   @"\u00e0", @"agrave",
                   @"\u00e1", @"aacute",
                   @"\u00e2", @"acirc",
                   @"\u00e3", @"atilde",
                   @"\u00e4", @"auml",
                   @"\u00e5", @"aring",
                   @"\u00e6", @"aelig",
                   @"\u00e7", @"ccedil",
                   @"\u00e8", @"egrave",
                   @"\u00e9", @"eacute",
                   @"\u00ea", @"ecirc",
                   @"\u00eb", @"euml",
                   @"\u00ec", @"igrave",
                   @"\u00ed", @"iacute",
                   @"\u00ee", @"icirc",
                   @"\u00ef", @"iuml",
                   @"\u00f0", @"eth",
                   @"\u00f1", @"ntilde",
                   @"\u00f2", @"ograve",
                   @"\u00f3", @"oacute",
                   @"\u00f4", @"ocirc",
                   @"\u00f5", @"otilde",
                   @"\u00f6", @"ouml",
                   @"\u00f7", @"divide",
                   @"\u00f8", @"oslash",
                   @"\u00f9", @"ugrave",
                   @"\u00fa", @"uacute",
                   @"\u00fb", @"ucirc",
                   @"\u00fc", @"uuml",
                   @"\u00fd", @"yacute",
                   @"\u00fe", @"thorn",
                   @"\u00ff", @"yuml",
                   @"\u0152", @"OElig",
                   @"\u0153", @"oelig",
                   @"\u0160", @"Scaron",
                   @"\u0161", @"scaron",
                   @"\u0178", @"Yuml",
                   @"\u0192", @"fnof",
                   @"\u02c6", @"circ",
                   @"\u02dc", @"tilde",
                   @"\u0393", @"Gamma",
                   @"\u0394", @"Delta",
                   @"\u0398", @"Theta",
                   @"\u039b", @"Lambda",
                   @"\u039e", @"Xi",
                   @"\u03a3", @"Sigma",
                   @"\u03a5", @"Upsilon",
                   @"\u03a6", @"Phi",
                   @"\u03a8", @"Psi",
                   @"\u03a9", @"Omega",
                   @"\u03b1", @"alpha",
                   @"\u0391", @"Alpha",
                   @"\u03b2", @"beta",
                   @"\u0392", @"Beta",
                   @"\u03b3", @"gamma",
                   @"\u03b4", @"delta",
                   @"\u03b5", @"epsilon",
                   @"\u0395", @"Epsilon",
                   @"\u03b6", @"zeta",
                   @"\u0396", @"Zeta",
                   @"\u03b7", @"eta",
                   @"\u0397", @"Eta",
                   @"\u03b8", @"theta",
                   @"\u03b9", @"iota",
                   @"\u0399", @"Iota",
                   @"\u03ba", @"kappa",
                   @"\u039a", @"Kappa",
                   @"\u03bb", @"lambda",
                   @"\u03bc", @"mu",
                   @"\u039c", @"Mu",
                   @"\u03bd", @"nu",
                   @"\u039d", @"Nu",
                   @"\u03be", @"xi",
                   @"\u03bf", @"omicron",
                   @"\u039f", @"Omicron",
                   @"\u03c0", @"pi",
                   @"\u03a0", @"Pi",
                   @"\u03c1", @"rho",
                   @"\u03a1", @"Rho",
                   @"\u03c2", @"sigmaf",
                   @"\u03c3", @"sigma",
                   @"\u03c4", @"tau",
                   @"\u03a4", @"Tau",
                   @"\u03c5", @"upsilon",
                   @"\u03c6", @"phi",
                   @"\u03c7", @"chi",
                   @"\u03a7", @"Chi",
                   @"\u03c8", @"psi",
                   @"\u03c9", @"omega",
                   @"\u03d1", @"thetasym",
                   @"\u03d2", @"upsih",
                   @"\u03d6", @"piv",
                   @"\u2002", @"ensp",
                   @"\u2003", @"emsp",
                   @"\u2009", @"thinsp",
                   @"\u2013", @"ndash",
                   @"\u2014", @"mdash",
                   @"\u2018", @"lsquo",
                   @"\u2019", @"rsquo",
                   @"\u201a", @"sbquo",
                   @"\u201c", @"ldquo",
                   @"\u201d", @"rdquo",
                   @"\u201e", @"bdquo",
                   @"\u2020", @"dagger",
                   @"\u2021", @"Dagger",
                   @"\u2022", @"bull",
                   @"\u2026", @"hellip",
                   @"\u2030", @"permil",
                   @"\u2032", @"prime",
                   @"\u2033", @"Prime",
                   @"\u2039", @"lsaquo",
                   @"\u203a", @"rsaquo",
                   @"\u203e", @"oline",
                   @"\u2044", @"frasl",
                   @"\u20ac", @"euro",
                   @"\u2111", @"image",
                   @"\u2118", @"weierp",
                   @"\u211c", @"real",
                   @"\u2122", @"trade",
                   @"\u2135", @"alefsym",
                   @"\u2190", @"larr",
                   @"\u2191", @"uarr",
                   @"\u2192", @"rarr",
                   @"\u2193", @"darr",
                   @"\u2194", @"harr",
                   @"\u21b5", @"crarr",
                   @"\u21d0", @"lArr",
                   @"\u21d1", @"uArr",
                   @"\u21d2", @"rArr",
                   @"\u21d3", @"dArr",
                   @"\u21d4", @"hArr",
                   @"\u2200", @"forall",
                   @"\u2202", @"part",
                   @"\u2203", @"exist",
                   @"\u2205", @"empty",
                   @"\u2207", @"nabla",
                   @"\u2208", @"isin",
                   @"\u2209", @"notin",
                   @"\u220b", @"ni",
                   @"\u220f", @"prod",
                   @"\u2211", @"sum",
                   @"\u2212", @"minus",
                   @"\u2217", @"lowast",
                   @"\u221a", @"radic",
                   @"\u221d", @"prop",
                   @"\u221e", @"infin",
                   @"\u2220", @"ang",
                   @"\u2227", @"and",
                   @"\u2228", @"or",
                   @"\u2229", @"cap",
                   @"\u222a", @"cup",
                   @"\u222b", @"int",
                   @"\u2234", @"there4",
                   @"\u223c", @"sim",
                   @"\u2245", @"cong",
                   @"\u2248", @"asymp",
                   @"\u2260", @"ne",
                   @"\u2261", @"equiv",
                   @"\u2264", @"le",
                   @"\u2265", @"ge",
                   @"\u2282", @"sub",
                   @"\u2283", @"sup",
                   @"\u2284", @"nsub",
                   @"\u2286", @"sube",
                   @"\u2287", @"supe",
                   @"\u2295", @"oplus",
                   @"\u2297", @"otimes",
                   @"\u22a5", @"perp",
                   @"\u22c5", @"sdot",
                   @"\u2308", @"lceil",
                   @"\u2309", @"rceil",
                   @"\u230a", @"lfloor",
                   @"\u230b", @"rfloor",
                   @"\u27e8", @"lang",
                   @"\u27e9", @"rang",
                   @"\u25ca", @"loz",
                   @"\u2660", @"spades",
                   @"\u2663", @"clubs",
                   @"\u2665", @"hearts",
                   @"\u2666", @"diams",
                   nil];
    });
    
    NSString *x = symbols[s];
    return x ? x : [NSString stringWithFormat:@"&%@;", s];
}

@implementation NSString (HTML)

- (NSString *)unescapeHTML
{
    NSMutableString *ms = [NSMutableString string];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    while (!scanner.isAtEnd) {
        
        NSString *s;
        
        if ([scanner scanUpToString:@"&" intoString:&s])
            [ms appendString:s];
        
        if (![scanner scanString:@"&" intoString:nil])
            break;
        
        if ([scanner scanUpToString:@";" intoString:&s]) {
            
            if ([scanner scanString:@";" intoString:nil]) {
                
                [ms appendString:stringFromHTMLSymbol(s)];
                
            } else {
                
                [ms appendString:@"&"];
                [ms appendString:s];
            }
        }
    }
    
    return ms;
}

- (NSString *) escapeHTML
{
    NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"<>&\""];
    NSMutableString *s = [NSMutableString string];
    
    NSInteger start = 0;
    NSInteger len = [self length];
    
    while (start < len) {
        NSRange r = [self rangeOfCharacterFromSet:chs
                                          options:0
                                            range:NSMakeRange(start, len-start)];
        
        if (r.location == NSNotFound) {
            [s appendString:[self substringFromIndex:start]];
            break;
        }
        
        if (start < r.location) {
            [s appendString:[self substringWithRange:NSMakeRange(start, r.location-start)]];
        }
        
        switch ([self characterAtIndex:r.location]) {
            case '<': [s appendString:@"&lt;"]; break;
            case '>': [s appendString:@"&gt;"]; break;
            case '"': [s appendString:@"&quot;"]; break;
            case '&': [s appendString:@"&amp;"]; break;
        }
        
        start = r.location + 1;
    }
    
    return s;
}

- (NSString *) stripHTML: (BOOL) replaceBlockTagsWithNewLine
{
    NSMutableString *ms = [NSMutableString string];
    
    NSCharacterSet *spaces = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    
    while (!scanner.isAtEnd) {
        
        NSString *s, *tag = nil;
        
        if ([scanner scanUpToString:@"<" intoString:&s])
            [ms appendString:s];
        
        if (![scanner scanString:@"<" intoString:nil])
            break;
        
        if ([scanner scanUpToString:@">" intoString:&tag] &&
            [scanner scanString:@">" intoString:nil]) {
            
            if (replaceBlockTagsWithNewLine) {
                
                tag = [tag.lowercaseString stringByTrimmingCharactersInSet:spaces];
                
                if ([tag hasSuffix:@"/"]) { // for case of <br />
                    tag = [tag substringToIndex:tag.length-1];
                    tag = [tag stringByTrimmingCharactersInSet:spaces];
                }
                
                if ([tag isEqualToString:@"br"] ||
                    [tag isEqualToString:@"p"] ||
                    [tag isEqualToString:@"div"] ||
                    [tag isEqualToString:@"dd"] ||
                    [tag isEqualToString:@"blockquote"]) {
                    
                    [ms appendString:@"\n"];
                }
            }
            
        } else {
            
            [ms appendString:@"<"];
            if (tag.length)
                [ms appendString:tag];
        }
    }
    
    //[ms stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    return ms;
}

- (NSString *)justReplaceHtmlTags{
    NSString *str = [self stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    return str;
}

@end
