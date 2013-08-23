//
//  Megalog.h
//  eXplora MuSe
//
//  Created by Nicolò Tosi on 7/17/13.
//  Copyright (c) 2013 MobFarm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDLog.h"

#define MFLogError(fmt,...) {\
[Megalog logErrorWithFormat:fmt,##__VA_ARGS__];\
}\

#define MFLogWarning(fmt,...){\
[Megalog logWarningWithFormat:fmt,##__VA_ARGS__];\
}\

#define MFLogInfo(fmt, ...) {\
[Megalog logInfoWithFormat:fmt,##__VA_ARGS__];\
}\

#define MFLogVerbose(fmt,...) {\
[Megalog logVerboseWithFormat:fmt,##__VA_ARGS__];\
}\

@interface Megalog : NSObject

+(void)logErrorWithFormat:(NSString *)format, ...;
+(void)logWarningWithFormat:(NSString *)format, ...;
+(void)logInfoWithFormat:(NSString *)format, ...;
+(void)logVerboseWithFormat:(NSString *)format, ...;

+(NSString *)currentLogFilePath;

@end
