//
//  WriteLog.m
//  IOSFramework
//
//  Created by allianture on 13-5-13.
//  Copyright (c) 2013年 allianture. All rights reserved.
//

#import "WriteLog.h"

@implementation WriteLog



void writeLog(int ulErrorLevel, const char *func, int lineNumber, NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    NSString *strFormat = [NSString stringWithFormat:@"%@%s, %@%i, %@%@",@"Function: ",func,@"Line: ",lineNumber, @"Format: ",string];
    
    NSString * strModelName = @"WriteLogTest"; //模块名
    
    NSString *strErrorLevel = [[NSString alloc] init];
    switch (ulErrorLevel) {
        case ERR_LOG:
            strErrorLevel = @"Error";
            break;
        case WARN_LOG:
            strErrorLevel = @"Warning";
            break;
        case NOTICE_LOG:
            strErrorLevel = @"Notice";
            break;
        case DEBUG_LOG:
            strErrorLevel = @"Debug";
            break;
        default:
            break;
    }
    NSLog(@"ModalName: %@, ErrorLevel: %@, %@.",strModelName, strErrorLevel, strFormat);
    
    
}





@end
