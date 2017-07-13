//
//  NetworkTools.h
//  Demo
//
//  Created by Allison on 2017/7/13.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkTools : NSObject
// 获取设备uuid
+ (NSString*)getUUID;
// 设备mac 地址
+ (NSString *)macaddress;
// Version
+ (NSString *)getVersion;
// SIM卡所属的运营商（公司）
+(NSString *)serviceCompany;

+(NSDictionary *)getDinfo;


@end
