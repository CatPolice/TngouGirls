//
//  ImageList.h
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "BaseModel.h"

@interface ImageList : BaseModel

@property (nonatomic , strong) NSNumber *fcount;
@property (nonatomic , strong) NSNumber *rcount;
@property (nonatomic , strong) NSNumber *ID;
@property (nonatomic , strong) NSNumber *count;
@property (nonatomic , strong) NSNumber *size;
@property (nonatomic , strong) NSNumber *galleryclass;
@property (nonatomic , copy) NSString *img;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , strong) NSNumber *time;

@property (nonatomic , copy) NSString *imgUrl;
@property (nonatomic , assign) NSInteger page;



+(NSURLSessionDataTask*)getImageList:(NSDictionary *)option
                                 Success:(void (^)(id responeObject , NSMutableArray *items))success
                                 Failure:(void (^)(NSError *error))failue;
@end
