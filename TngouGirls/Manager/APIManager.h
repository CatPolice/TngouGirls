//
//  APIManager.h
//  TngouGirls
//
//  Created by runlin on 17/4/17.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface APIManager : AFHTTPSessionManager
+ (instancetype)sharedManager;

+ (NSURLSessionDataTask *)SafePOST:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLResponse *respone, id responseObject))success
                           failure:(void (^)(NSURLResponse *respone, NSError *error))failure;

+ (NSURLSessionDataTask *)SafeGET:(NSString *)URLString
                       parameters:(id)parameters
                          success:(void (^)(NSURLResponse *respone, id responseObject))success
                          failure:(void (^)(NSURLResponse *respone, NSError *error))failure;

@end
