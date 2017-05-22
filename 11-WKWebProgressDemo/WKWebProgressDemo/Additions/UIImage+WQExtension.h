//
//  UIImage+WQExtension.h
//  TestAddtions
//
//  Created by 吴强 on 2017/4/28.
//  Copyright © 2017年 ChongqingWirelessOasisCommunicationTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WQExtension)
/**
 重绘size大小的图片
 
 @param size 重绘的size
 @return 新大小的图片
 */
- (UIImage *)cz_getScaleImageToSize:(CGSize)size;

/**
 等比率缩放
 
 @param scaleSize 缩放比例
 @return  新大小的图片
 */
- (UIImage *)cz_getScaleImageToScale:(CGFloat)scaleSize;

/**
 获取rect截图区域内的image
 
 @param rect 截图区域
 @return 截图区域内的image
 */
- (UIImage *)cz_getRectImage:(CGRect)rect;
@end
