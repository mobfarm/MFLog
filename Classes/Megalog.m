//
//  Megalog.m
//  eXplora MuSe
//
//  Created by Nicolò Tosi on 7/17/13.
//  Copyright (c) 2013 MobFarm. All rights reserved.
//

#import "Megalog.h"
#import "DDLog.h"
#import "DDFileLogger.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"
#import "Commons.h"

@implementation Megalog

+(NSString *)currentLogFilePath
{
    DDFileLogger * fileLogger = [Megalog defaultFileLogger];
    return [[fileLogger.logFileManager sortedLogFilePaths]objectAtIndex:0];
}

+(void)logErrorWithFormat:(NSString *)format, ...
{
    va_list args1;
    va_start(args1, format);
    NSString * logMessage = [Megalog formatLogMessage:format arguments:args1 type:@"Error"];
    va_end(args1);
    
    DDLogError(@"%@", logMessage);
    NSLog(@"%@", logMessage);
}

+(void)logWarningWithFormat:(NSString *)format, ...
{
    va_list args1;
    va_start(args1, format);
    NSString * logMessage = [Megalog formatLogMessage:format arguments:args1 type:@"Warning"];
    va_end(args1);
    
    DDLogWarn(@"%@", logMessage);
    NSLog(@"%@", logMessage);}

+(void)logInfoWithFormat:(NSString *)format, ...
{
    va_list args1;
    va_start(args1, format);
    NSString * logMessage = [Megalog formatLogMessage:format arguments:args1 type:@"Info"];
    va_end(args1);
    
    DDLogInfo(@"%@", logMessage);
    NSLog(@"%@", logMessage);
}

+(void)logVerboseWithFormat:(NSString *)format, ...
{
    va_list args1;
    va_start(args1, format);
    NSString * logMessage = [Megalog formatLogMessage:format arguments:args1 type:@"Verbose"];
    va_end(args1);
    
    DDLogVerbose(@"%@", logMessage);
    NSLog(@"%@", logMessage);
}

/*
+(void)logMessageWithFormat:(NSString *)format arguments:(va_list)arguments type:(NSString *)type
{
    NSString * logMessage = [Megalog formatLogMessage:format arguments:arguments type:type];
    NSLog(@"%@", logMessage);
}
*/

#pragma mark -

+(NSString *)formatLogMessage:(NSString *)message arguments:(va_list)arguments type:(NSString *)type
{
    NSString * logMessage = [[NSString alloc]initWithFormat:message arguments:arguments];
    //NSString * timestamp = [[Megalog defaultDateFormatter]stringFromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%@ - %@\n", type, logMessage];
}

+(NSDateFormatter *)defaultDateFormatter
{
    static NSDateFormatter * dateFormatter = nil;
    if(!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm:ss:SSS";
    }
    return dateFormatter;
}

+(void)initialize
{
    /*
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    */
    DDFileLogger * fileLogger = [Megalog defaultFileLogger];
    [DDLog addLogger:fileLogger];
}

+(DDFileLogger *)defaultFileLogger
{
    static DDFileLogger * fileLogger = nil;
    if(!fileLogger)
    {
        NSString * logsDirectory = [Megalog defaultLogsDirectory];
        DDLogFileManagerDefault * logFileManager = [[DDLogFileManagerDefault alloc]initWithLogsDirectory:logsDirectory];
        logFileManager.maximumNumberOfLogFiles = 10;
        
        fileLogger = [[DDFileLogger alloc]initWithLogFileManager:logFileManager];
        fileLogger.maximumFileSize = 10000; // 10 kB
        fileLogger.rollingFrequency = 60 * 60 * 24; // 24 ore
        
    }
    return fileLogger;
}

+(NSString *)filePathForDefaultLogsDirectory
{
    return [[Commons filePathForApplicationCachesDirectory]stringByAppendingPathComponent:@"Logs"];
}

+(NSString *)defaultLogsDirectory
{
    NSString * path = [Megalog filePathForDefaultLogsDirectory];
    
    if(![[NSFileManager defaultManager]fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager]createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

@end
