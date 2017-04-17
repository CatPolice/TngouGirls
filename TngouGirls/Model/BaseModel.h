//
//  BaseModel.h
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "JSONModel.h"
#import "NSArray+JKSafeAccess.h"
#import "NSDictionary+JKSafeAccess.h"
#import "APIManager.h"
#import "Constant.h"

@interface BaseModel : JSONModel
+(id)objectFromDictionary:(NSDictionary*)dict;
//获取所有属性列表
+ (NSArray *)classPropertyList;
//字典中key分组数组
+(NSDictionary*)convertToGroupArray:(NSArray*)result;
//属性转成字典,一般使用  -(NSDictionary*)toDictionary即可
-(NSDictionary *)propertyDictionary;
@end
