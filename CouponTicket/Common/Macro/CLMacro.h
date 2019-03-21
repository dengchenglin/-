//
//  CLDevice.h
//  GeihuiCould
//
//  Created by dengchenglin on 2018/8/29.
//  Copyright © 2018年 Qianmeng. All rights reserved.
//

#ifndef CLMacro_h
#define CLMacro_h

/* 设备信息 */

//系统
#define IOS_8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
#define IOS_9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
#define IOS_10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)
#define IOS_11 ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)
#define IOS_11 ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)

//设备判断
#define IS_IPHONE4  ([[UIScreen mainScreen] bounds].size.height == 480)
#define IS_IPHONE5  ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_iPhone6  ([[UIScreen mainScreen] bounds].size.width == 375)
#define IS_iPhone6s ([[UIScreen mainScreen] bounds].size.width == 414)
#define IS_iPhoneX  ([[UIScreen mainScreen] bounds].size.height == 812)
#define IS_iPhoneXM ([[UIScreen mainScreen] bounds].size.height == 896)
#define IS_Than_IPhoneX ([[UIScreen mainScreen] bounds].size.height >= 812)

#define IS_Than_iPhoneX (IS_iPhoneX||IS_iPhoneXM)
#define Is_Than_iPhone6 (([[UIScreen mainScreen] bounds].size.width >= 375)?YES:NO)

//屏幕尺寸
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width

#define AUTO_X  SCREEN_WIDTH/320
#define AUTO_Y  (IS_iPhoneX?SCREEN_WIDTH/320:(SCREEN_HEIGHT>480 ? SCREEN_HEIGHT/568 : 1.0))
#define AUTO_FONT ((SCREEN_WIDTH == 320) ? 1 : (AUTO_X * 0.93))

//像素缩放
#define SCREEN_SCALE [UIScreen mainScreen].scale

//iphone6以下尺寸缩放系数
#define SIZE_SCALE  ([[UIScreen mainScreen] bounds].size.width/375)


/**
 * 导航与TabBar
 */
#define NAVBAR_HEIGHT ((IS_iPhoneX|IS_iPhoneXM) ? (64 + 24) : 64)
#define TABBAR_HEIGHT ((IS_iPhoneX|IS_iPhoneXM) ? (49 + 24) : 49)
#define NAVBAR_TOP ((IS_iPhoneX|IS_iPhoneXM) ? 24 : 0)
#define BOTTOM_HEIGHT (IS_Than_IPhoneX?10:0)


/*颜色*/
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]
#define HexColor(hexString)  [UIColor colorWithHexString:hexString]
/*字体*/
#define FONT_PFRG_SIZE(s) [UIFont systemFontOfSize:s]

#define BLOD_FONT_SIZE(s) [UIFont fontWithName:@"Helvetica-Bold" size:s]

/*线宽*/
#define LINE_WIDTH (1/SCREEN_SCALE)


/* 工具宏 */
//单例
#define SINGLETON_FOR_CLASS_DEF  \
+ (instancetype) sharedInstance;

#define SINGLETON_FOR_CLASS_IMP(class)\
+ (instancetype) sharedInstance    \
{\
static class *instance;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance = [[class alloc] init];\
});\
return instance;\
}\

#define SINGLETON_INHERIT_FOR_CLASS_IMP \
+ (instancetype)sharedInstance\
{\
    id instance = objc_getAssociatedObject(self, @"instance");\
    if (!instance)\
    {\
        instance = [[super allocWithZone:NULL] init];\
        objc_setAssociatedObject(self, @"instance", instance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
    }\
    return instance;\
}\
+ (id)allocWithZone:(struct _NSZone *)zone\
{\
    return [self sharedInstance] ;\
}\
- (id)copyWithZone:(struct _NSZone *)zone\
{\
    Class selfClass = [self class];\
    return [selfClass sharedInstance];\
}\



//加载xib
#define NSMainBundleClass(class) [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(class) owner:self options:nil][0]

#define NSMainBundleName(name) [[NSBundle mainBundle]loadNibNamed:name owner:self options:nil][0]

//通知
#define POST_NOTIFICATION(name)  [[NSNotificationCenter defaultCenter]postNotificationName:name object:nil];

//view的初始化
#define ViewInstance(setUpName) \
- (instancetype)initWithFrame:(CGRect)frame{\
if(self = [super initWithFrame:frame]){[self setUpName];}\
return self;}\
- (void)awakeFromNib{\
[super awakeFromNib];\
[self setUpName];}

//编码
#define EnCodingNSString(s) (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef)s,NULL,CFSTR("!*’();:@&=+$,/?%#[]"),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))

//docoument
#define CLDocumentPath(pathKey) [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",pathKey]]

//debug log
#ifdef DEBUG
#define DBLog(s, ...)    NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define DBLog(s, ...) {}
#endif


#endif /* CLDevice_h */
