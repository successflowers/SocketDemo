//
//  CCPerson.m
//  NetWorkingDemo
//
//  Created by 张敬 on 2020/2/12.
//  Copyright © 2020年 xiuxiu. All rights reserved.
//

#import "CCPerson.h"

@implementation CCPerson

+ (instancetype)personWithDic:(NSDictionary *)dic{
    CCPerson *p = [self new];
    [p setValuesForKeysWithDictionary:dic];
    return p;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"===== name: %@, sex: %d", self.name, self.sex.intValue];
}

@end
