//
//  HomeViewController.m
//  NetWorkingDemo
//
//  Created by 张敬 on 2020/2/13.
//  Copyright © 2020年 xiuxiu. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // NSLog(@"%@", [self time]);
    //[self time];
    
    NSString * baseStr = [self base64EncodeStr:@"章节"];
    NSLog(@"%@", baseStr);
    
    NSString * str = [self strWithBase64:baseStr];
    NSLog(@"%@", str);
    
    NSLog(@"%@", [[NSBundle mainBundle] bundleIdentifier]);
}


/**
 字符串->base64
 */
- (NSString *)base64EncodeStr:(NSString *)str{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedDataWithOptions:0];
}
/**
 base64->字符串
 */
- (NSString *)strWithBase64:(NSString *)str{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/**
 时间格式化
 */
- (void)time{

    //NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:1581512444];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:1581512444];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *com = [calender components:NSCalendarUnitMinute fromDate:date toDate:[NSDate date] options:0];
    if (com.minute < 60) {
        NSLog([NSString stringWithFormat:@"%zd分钟之前", com.minute]);
        return;
    }

    com = [calender components:NSCalendarUnitHour fromDate:date toDate:[NSDate date] options:0];
    if (com.hour < 24) {
        NSLog([NSString stringWithFormat:@"%zd小时之前", com.hour]);
        return;
    }

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM-dd HH:ss";
    NSLog(@"%@", [formatter stringFromDate:date]);
}

@end
