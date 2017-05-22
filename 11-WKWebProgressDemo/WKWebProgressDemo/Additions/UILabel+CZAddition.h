//
//  UILabel+CZAddition.h
//
//  Created by 刘凡 on 16/4/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CZAddition)

/**
 创建文本标签，可换行
 
 @param text 文字
 @param fontSize 字体大小
 @param color 字体颜色
 @return 返回label
 */
+ (instancetype)cz_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color;
/**
 *  设置字间距
 */
- (void)cz_setColumnSpace:(CGFloat)columnSpace;

/**
 *  设置行距
 */
- (void)cz_setRowSpace:(CGFloat)rowSpace;


/**
 *  将一个已经初始化的label设置行间距等属性后，返回一个适合大小的label
 *
 *  @param text      label的文字
 *  @param x         label的x
 *  @param y         label的y
 *  @param maxWidth  label的最大宽度
 *  @param fontSize  label的文字大小
 *  @param lineSpace label的行间距
 */
+ (instancetype)cz_getLineSpacingLabelWithString:(NSString *)text X:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)maxWidth Font:(CGFloat)fontSize LineSpace:(CGFloat)lineSpace;

@end
