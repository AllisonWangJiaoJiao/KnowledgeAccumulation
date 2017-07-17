//
//  UILabel+CZAddition.m
//
//  Created by 刘凡 on 16/4/21.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UILabel+CZAddition.h"
#import <CoreText/CoreText.h>

@implementation UILabel (CZAddition)


/**
 创建文本标签，可换行
 
 @param text 文字
 @param fontSize 字体大小
 @param color 字体颜色
 @return 返回label
 */
+ (instancetype)cz_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color {
    UILabel *label = [[self alloc] init];
    
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    label.numberOfLines = 0;
    
    [label sizeToFit];
    
    return label;
}

/**
 *  设置字间距
 */
- (void)cz_setColumnSpace:(CGFloat)columnSpace
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(columnSpace) range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
}

/**
 *  设置行距
 */
- (void)cz_setRowSpace:(CGFloat)rowSpace
{
    self.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}


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
+ (instancetype)cz_getLineSpacingLabelWithString:(NSString *)text X:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)maxWidth Font:(CGFloat)fontSize LineSpace:(CGFloat)lineSpace
{
    UILabel *label = [[UILabel alloc] init];
    // 设置label的属性
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    // 必须设置字体的
    label.font = [UIFont systemFontOfSize:fontSize];
    
    // 根据内容设置label的大小,先设置初始的x,y,width
    label.frame = CGRectMake(x, y, maxWidth, 0);
    
    // 设置label的行间距
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    // 行间距为
    [paragraphStyle setLineSpacing:lineSpace];
    
    // 设置文字属性的范围
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    // 将attributeString赋值给label的attributedText
    label.attributedText = attributeString;
    
    // 最关键的一步，之后就获取高度就直接用 label.bounds.size.width
    [label sizeToFit];
    
    // 返回此label
    return label;
}

@end
