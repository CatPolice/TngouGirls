//
//  BaseModel.m
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"ID"
                                                       }];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
-(NSString *)description{
    return [self toJSONString];
}
+(id)objectFromDictionary:(NSDictionary*)dict{
    return  [[self alloc] initWithDictionary:dict error:nil];
}
//获取所有属性列表
+ (NSArray *)classPropertyList {
    NSMutableArray *allProperties = [[NSMutableArray alloc] init];
    
    unsigned int outCount;
    objc_property_t *props = class_copyPropertyList(self, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t prop = props[i];
        
        NSString *propName = [[NSString alloc]initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        
        if (propName) {
            [allProperties addObject:propName];
        }
    }
    free(props);
    return [NSArray arrayWithArray:allProperties];
}
//字典中key分组数组
+(NSDictionary*)convertToGroupArray:(NSArray*)result{
    
    NSMutableDictionary *items = [NSMutableDictionary dictionary];
    NSArray *keys = [self classPropertyList];
    
    for (NSDictionary *object in result) {
        
        for (NSString *key in keys) {
            id value = [object objectForKey:key];
            NSMutableArray *array = [items objectForKey:key]?:([NSMutableArray array]);
            [array addObject:value?:@""];
            [items setObject:array forKey:key];
        }
    }
    return items;
}

//属性转成字典,一般使用  -(NSDictionary*)toDictionary即可
-(NSDictionary *)propertyDictionary
{
    //创建可变字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *props = class_copyPropertyList([self class], &outCount);
    for(int i=0;i<outCount;i++){
        objc_property_t prop = props[i];
        NSString *propName = [[NSString alloc]initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        id propValue = [self valueForKey:propName];
        //        if(propValue){
        [dict setObject:propValue?:[NSNull null] forKey:propName];
        //        }
    }
    free(props);
    return dict;
}

@end

