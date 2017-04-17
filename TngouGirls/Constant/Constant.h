//
//  Constant.h
//  AFNetworking-demo
//
//  Created by Jakey on 15/6/3.
//  Copyright (c) 2015年 Jakey. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifdef SYNTHESIZE_CONSTS
# define CONST(name, value) NSString* const name = @ value
#else
# define CONST(name, value) extern NSString* const name
#endif

#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif



CONST(URI_BASE_SERVER, "http://www.tngou.net/");

CONST(API_VERSION, "1.2");

CONST(URI_BASE_IMG_SERVER, "http://tnfs.tngou.net/image");

/*====================================接口============================================*/

CONST(URI_INTERFACES_TNFS_API_CLASSIFY, "tnfs/api/classify"); // 图片分类
CONST(URI_INTERFACES_TNFS_API_LIST, "tnfs/api/list"); // 图片列表

CONST(URI_INTERFACES_TNFS_SHOW, "tnfs/show/"); // 详细信息






@interface Constant : NSObject

@end
