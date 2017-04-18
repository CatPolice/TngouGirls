//
//  ImageCategory.h
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "BaseModel.h"

@interface ImageCategory : BaseModel

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
