//
//  CLNetworkDefines.h
//  YMKMain
//
//  Created by dengchenglin on 2018/6/28.
//  Copyright © 2018年 Property. All rights reserved.
//


#ifndef CLNetworkDefines_h
#define CLNetworkDefines_h

#ifdef DEBUG
#define CLNetLog(s, ...)    NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define CLNetLog(s, ...) {}
#endif

#define CL_NETWORK_SAFE_BLOCK(blockName, ...) ({ !blockName ? nil : blockName(__VA_ARGS__); })


#endif
