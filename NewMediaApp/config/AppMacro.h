//
//  AppMacro.h
//  NewMediaApp
//
//  Created by PengLinmao on 16/5/17.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

#define CTColorString(color)  [CommUtils colorWithHexString:color];


#define NMScreenFrameW [[UIScreen mainScreen] bounds].size.width
#define NMScreenNavHeight 64
#define NMScreenFrameH [[UIScreen mainScreen] bounds].size.height
#define NMSecondMenuTitleColor  CTColorString(@"#555555")
#define TIMEOUT 60
//单例模式
#define SYNTHESIZE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

//单例化一个类
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}



#endif /* AppMacro_h */
