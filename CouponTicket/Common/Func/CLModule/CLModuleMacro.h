//
//  CLModuleDefines.h
//  YMKMain
//
//  Created by dengchenglin on 2018/6/26.
//  Copyright © 2018年 Property. All rights reserved.
//

#ifndef CLModuleMacro_h
#define CLModuleMacro_h

#define CL_EXPORT_MODULE(pro) \
+ (void)load{[CLModuleManager registerModuleServiceForClass:[self class] protocol:@protocol(pro)];}

#define CL_REGISTER_MODULE(service,pro) \
+ (void)load{[CLModuleManager registerModuleServiceForClass:[service class] protocol:@protocol(pro)];}

#endif /* CLModuleDefines_h */
