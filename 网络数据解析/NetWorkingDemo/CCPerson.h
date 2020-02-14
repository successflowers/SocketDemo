//
//  CCPerson.h
//  NetWorkingDemo
//
//  Created by 张敬 on 2020/2/12.
//  Copyright © 2020年 xiuxiu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCPerson : NSObject

@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *sex;
//@property (nonatomic, assign) int sex;
@property (nonatomic, strong) NSNumber *sex;



+ (instancetype)personWithDic:(NSDictionary *)dic;
@end


NS_ASSUME_NONNULL_END
