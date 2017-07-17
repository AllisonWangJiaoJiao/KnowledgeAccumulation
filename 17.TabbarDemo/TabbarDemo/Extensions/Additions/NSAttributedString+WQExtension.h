//
//  NSAttributedString+WQExtension.h
//  TestAddtions
//
//  Created by 吴强 on 2017/4/27.
//  Copyright © 2017年 ChongqingWirelessOasisCommunicationTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (WQExtension)

/**
 使用图像和文本生成上下排列的属性文本

 @param image 图像
 @param imageWH 图像宽高
 @param title 标题文字
 @param fontSize 标题字体大小
 @param titleColor 标题颜色
 @param spacing 图像和标题间距
 @return 属性文本
 */
+ (instancetype)cz_imageTextWithImage:(UIImage *)image
                              imageWH:(CGFloat)imageWH
                                title:(NSString *)title
                             fontSize:(CGFloat)fontSize
                           titleColor:(UIColor *)titleColor
                              spacing:(CGFloat)spacing;


#pragma mark - 计算
/**
 获取最大的高度
 
 @param width 限定的宽度 
 @return 高度
 */
- (CGFloat)cz_getMaxHeightWithWidth:(CGFloat)width;
/**
 获取最大的宽度
 
 @param height 限定的高度
 @return 宽度
 */
- (CGFloat)cz_getMaxWidthWithHeight:(CGFloat)height;
/**
 获取最大的宽高
 
 @param width 限定的宽度
 @param height 限定的高度
 @return 宽高
 */
- (CGSize)cz_getSizeWithWidth:(CGFloat)width Height:(CGFloat)height;
@end
