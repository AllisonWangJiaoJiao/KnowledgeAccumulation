//
//  NSAttributedString+WQExtension.m
//  TestAddtions
//
//  Created by 吴强 on 2017/4/27.
//  Copyright © 2017年 ChongqingWirelessOasisCommunicationTechnology. All rights reserved.
//

#import "NSAttributedString+WQExtension.h"

@implementation NSAttributedString (WQExtension)
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
                              spacing:(CGFloat)spacing{
    
    // 文本字典
    NSDictionary *titleDict = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize],
                                NSForegroundColorAttributeName: titleColor};
    NSDictionary *spacingDict = @{NSFontAttributeName: [UIFont systemFontOfSize:spacing]};
    
    // 图片文本
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, imageWH, imageWH);
    NSAttributedString *imageText = [NSAttributedString attributedStringWithAttachment:attachment];
    
    // 换行文本
    NSAttributedString *lineText = [[NSAttributedString alloc] initWithString:@"\n\n" attributes:spacingDict];
    
    // 按钮文字
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:title attributes:titleDict];
    
    // 合并文字
    NSMutableAttributedString *attM = [[NSMutableAttributedString alloc] initWithAttributedString:imageText];
    [attM appendAttributedString:lineText];
    [attM appendAttributedString:text];
    
    return attM.copy;
}
#pragma mark - 计算
/**
 获取最大的高度
 
 @param width 限定的宽度
 @return 高度
 */
- (CGFloat)cz_getMaxHeightWithWidth:(CGFloat)width{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size.height;
}

/**
 获取最大的宽度
 
 @param height 限定的高度
 @return 宽度
 */
- (CGFloat)cz_getMaxWidthWithHeight:(CGFloat)height{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options: NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size.width;
}

/**
 获取最大的宽高
 
 @param width 限定的宽度
 @param height 限定的高度
 @return 宽高
 */
- (CGSize)cz_getSizeWithWidth:(CGFloat)width Height:(CGFloat)height{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, height) options: NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size;
}
@end
