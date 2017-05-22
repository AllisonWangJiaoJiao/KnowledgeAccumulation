//
//  UIView+CZAddition.h
//
//  Created by 刘凡 on 16/5/11.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CZAddition)

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGPoint origin;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;

/// 返回视图截图
- (UIImage *)cz_snapshotImage;
/**
 返回从nib创建的view
 
 @param nibNameOrNil nibName 为空表示和调用此方法的class同名
 @param bundleOrNil bundle 为空表示mainBundle
 @param owner owner
 @return view
 */
+ (id)cz_getInstanceWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)bundleOrNil owner:(id)owner;
@end
