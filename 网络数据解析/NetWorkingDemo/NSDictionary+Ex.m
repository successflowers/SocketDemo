//
//  NSDictionary+Ex.m
//  NetWorkingDemo
//
//  Created by 张敬 on 2020/2/12.
//  Copyright © 2020年 xiuxiu. All rights reserved.
//

#import "NSDictionary+Ex.h"

@implementation NSDictionary (Ex)

//- (NSString *)descriptionWithLocale:(id)locale
//{
//    NSMutableString *string = [NSMutableString string];
//
//    // 开头有个{
//    [string appendString:@"{\n"];
//
//    // 遍历所有的键值对
//    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        [string appendFormat:@"\t%@", key];
//        [string appendString:@" : "];
//        [string appendFormat:@"%@,\n", obj];
//    }];
//
//    // 结尾有个}
//    [string appendString:@"}"];
//
//    // 查找最后一个逗号
//    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
//    if (range.location != NSNotFound)
//        [string deleteCharactersInRange:range];
//
//    return string;
//
//}

//重写系统的方法控制输出 indent 缩进
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *mStr = [NSMutableString string];
    NSMutableString *tabStr = [NSMutableString stringWithString:@""];
    for (int i = 0; i < level; i++) {
        [tabStr appendString:@"\t"];
    }
    [mStr appendString:@"{\n"];
    
    NSArray *allKey = self.allKeys;
    for (int i = 0; i < allKey.count; i++) {
        id value = self[allKey[i]];
        NSString *lastSymbol = (allKey.count == i + 1) ? @"":@",";
        if ([value respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
            [mStr appendFormat:@"\t%@%@ = %@%@\n",tabStr,allKey[i],[value descriptionWithLocale:locale indent:level + 1],lastSymbol];
        } else {
            [mStr appendFormat:@"\t%@%@ = %@%@\n",tabStr,allKey[i],value,lastSymbol];
        }
    }
    [mStr appendFormat:@"%@}",tabStr];
    return mStr;
}


@end
