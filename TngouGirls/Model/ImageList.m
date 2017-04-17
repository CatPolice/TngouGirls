//
//  ImageList.m
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "ImageList.h"

@implementation ImageList
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"ID"
                                                       }];
}

+(NSURLSessionDataTask*)getImageList:(NSDictionary *)option
                                 Success:(void (^)(id responeObject , NSMutableArray *items))success
                                 Failure:(void (^)(NSError *error))failue{
    return [APIManager SafePOST:URI_INTERFACES_TNFS_API_LIST parameters:option success:^(NSURLResponse *respone, id responseObject) {
        
        if (responseObject == nil || ![responseObject jk_boolForKey:@"status"]) {
            success(nil,nil);
            return ;
        }
        
        NSMutableArray *items = [NSMutableArray array];
        NSArray *arrayResult = [responseObject jk_arrayForKey:@"tngou"];
        
        for (NSDictionary *jsonObj in arrayResult) {
            NSError *err;
            ImageList *item = [[ImageList alloc] initWithDictionary:jsonObj error:&err];
            item.imgUrl = [NSString stringWithFormat:@"%@%@%@",URI_BASE_IMG_SERVER,item.img,@"_150x230"];
            [items addObject:item];
        }
        
        success(responseObject,items);
        
    } failure:^(NSURLResponse *respone, NSError *error) {
        failue(error);
    }];
}
@end
