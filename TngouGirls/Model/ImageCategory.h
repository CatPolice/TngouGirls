//
//  ImageCategory.h
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "BaseModel.h"

@interface ImageCategory : BaseModel



//{
//    "status" : true,
//    "tngou" : [
//               {
//                   "id" : 1,
//                   "seq" : 1,
//                   "keywords" : "性感美女",
//                   "description" : "性感美女",
//                   "name" : "性感美女",
//                   "title" : "性感美女"
//               },
//               {
//                   "id" : 2,
//                   "seq" : 2,
//                   "keywords" : "韩日美女",
//                   "description" : "韩日美女",
//                   "name" : "韩日美女",
//                   "title" : "韩日美女"
//               },
//               {
//                   "id" : 3,
//                   "seq" : 3,
//                   "keywords" : "丝袜美腿",
//                   "description" : "丝袜美腿",
//                   "name" : "丝袜美腿",
//                   "title" : "丝袜美腿"
//               },
//               {
//                   "id" : 4,
//                   "seq" : 4,
//                   "keywords" : "美女照片",
//                   "description" : "美女照片",
//                   "name" : "美女照片",
//                   "title" : "美女照片"
//               },
//               {
//                   "id" : 5,
//                   "seq" : 5,
//                   "keywords" : "美女写真",
//                   "description" : "美女写真",
//                   "name" : "美女写真",
//                   "title" : "美女写真"
//               },
//               {
//                   "id" : 6,
//                   "seq" : 6,
//                   "keywords" : "清纯美女",
//                   "description" : "清纯美女",
//                   "name" : "清纯美女",
//                   "title" : "清纯美女"
//               },
//               {
//                   "id" : 7,
//                   "seq" : 7,
//                   "keywords" : "性感车模",
//                   "description" : "性感车模",
//                   "name" : "性感车模",
//                   "title" : "性感车模"
//               }
//               ]
//}

@property (nonatomic , strong)NSNumber *ID;
@property (nonatomic , strong)NSNumber *seq;
@property (nonatomic , copy)NSString *keywords;
@property (nonatomic , copy)NSString *reDescription;
@property (nonatomic , copy)NSString *name;
@property (nonatomic , copy)NSString *title;




+(NSURLSessionDataTask*)getImageCategory:(NSDictionary *)option
                                 Success:(void (^)(id responeObject , NSMutableArray *items))success
                                 Failure:(void (^)(NSError *error))failue;
@end
