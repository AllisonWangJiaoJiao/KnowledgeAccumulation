//
//  ViewController.m
//  Demo
//
//  Created by Allison on 2017/7/13.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "NetworkTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *uuidStr = [NetworkTools getUUID];
//    NSLog(uuidStr);
//    
//    NSString *str = [NetworkTools macaddress];
//    NSLog(str);
  
    NSDictionary *infoDic = [NetworkTools getDinfo];
    NSLog(@"%@", infoDic);
    

    
    
    //状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    id statusBar = [app valueForKeyPath:@"statusBar"];
    // 遍历状态栏的所有成员
    unsigned int outCount =0;
    Ivar *ivars = class_copyIvarList([statusBar class], &outCount);
    for (int i =0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        printf("%s\n",ivar_getName(ivar));
    }

    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    for (id child in children) {

        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            unsigned int outCount =0;
            Ivar *ivars = class_copyIvarList([child class], &outCount);
            for (int i =0; i < outCount; i++) {
                Ivar ivar = ivars[i];
                printf("%s\n",ivar_getName(ivar));
            }
            //获取到状态栏
           NSInteger netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
           NSLog(@"netType: %ld", netType);
            
            //wifi信号强度
            int signalStrength = [[child valueForKeyPath:@"wifiStrengthBars"]intValue];
            NSLog(@"netType: %d", signalStrength);

        }

        
        
}

    
    
    
}


- (UIView*)statusBarView;
{
    UIView *statusBar = nil;
    NSData *data = [NSData dataWithBytes:(unsigned char []){0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x61, 0x72} length:9];
    NSString *key = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    id object = [UIApplication sharedApplication];
    if ([object respondsToSelector:NSSelectorFromString(key)]) statusBar = [object valueForKey:key];
    return statusBar;
}

@end
