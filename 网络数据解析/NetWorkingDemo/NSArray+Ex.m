//
//  NSArray+Ex.m
//  NetWorkingDemo
//
//  Created by 张敬 on 2020/2/12.
//  Copyright © 2020年 xiuxiu. All rights reserved.
//

#import "NSArray+Ex.h"
#import <objc/runtime.h>


@implementation NSArray (Ex)

//- (NSString *)descriptionWithLocale:(id)locale
//{
//    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
//
//    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [strM appendFormat:@"\t%@,\n", obj];
//    }];
//
//    [strM appendString:@")"];
//
//    return strM;
//
//}

+ (void)load{
    Method old = class_getInstanceMethod(self, @selector(description));
    Method new = class_getInstanceMethod(self, @selector(jh_description));
    method_exchangeImplementations(old, new);
    
    {
        Method old = class_getInstanceMethod(self, @selector(descriptionWithLocale:));
        Method new = class_getInstanceMethod(self, @selector(jh_descriptionWithLocale:));
        method_exchangeImplementations(old, new);
    }
}

- (NSString *)jh_description{
    NSString *description = [self jh_description];
    description = [NSString stringWithCString:[description cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return description;
}

- (NSString *)jh_descriptionWithLocale:(id)local{
    return [self description];
}


@end
