//
//  NSString+WQExtension.m
//  TestAddtions
//
//  Created by 吴强 on 2017/4/27.
//  Copyright © 2017年 ChongqingWirelessOasisCommunicationTechnology. All rights reserved.
//

#import "NSString+WQExtension.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (WQExtension)

#pragma mark - 正则匹配

/**
 *  是否为电话号码
 */
- (BOOL)cz_isTelephoneNum{
    NSString *phoneNumRegex1 = @"^((14[0-9])|(17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *phoneNum1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNumRegex1];
    
    return [phoneNum1 evaluateWithObject:self];
}

/**
 是否为车牌号
 */
- (BOOL)cz_isLicenseNumber{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

/**
 是否为邮箱格式
 */
- (BOOL)cz_isValidateEmail{
    NSString *emailPattern = @"^[-.0-9_\\p{letter}]+@[0-9\\p{letter}]+(\\.[-0-9_\\p{letter}]+)+$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:emailPattern options:0 error:nil];
    NSTextCheckingResult *math = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    if (math) {
        return YES;
    }
    return NO;
}

/**
 *  是否为身份证号15或18位
 */
- (BOOL)cz_isIdCard{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

/**
 *  是否为邮编
 */
- (BOOL)cz_isZipCode{
    NSString *pattern = @"[1-9]\\d{5}(?!\\d)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
/**
 *  是否为纯数字
 */
- (BOOL)cz_validateNumb{
    NSString *emailPattern = @"^[0-9]+([.]{0}|[.]{1}[0-9]+)$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:emailPattern options:0 error:nil];
    NSTextCheckingResult *math = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    if (math) {
        return YES;
    }
    return NO;
}

/**
 *  是否为纯汉字
 */
- (BOOL)cz_isChineseText{
    NSString *pattern = @"^[\u4E00-\u9FA5]*$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSTextCheckingResult *math = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    if (math) {
        return YES;
    }
    return NO;
}

/**
 *  是否有值
 */
- (BOOL)cz_isNotNil{
    if (self && ![self isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}
/**
 *  判断是否为整形
 */
- (BOOL)cz_isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

/**
 *  判断是否为浮点形
 */
- (BOOL)cz_isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

/**
 *  判断是否包含某字符串
 */
- (BOOL)cz_isContainsSubString:(NSString *)subString{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        return [self containsString:subString];
    }else
        return [self rangeOfString:subString].location != NSNotFound;
}


#pragma mark - 计算
/**
 获取最大的高度
 
 @param width 限定的宽度
 @param fontSize 字体大小
 @return 高度
 */
- (CGFloat)cz_getMaxHeightWithWidth:(CGFloat)width Font:(CGFloat)fontSize{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.width;
}

/**
 获取最大的宽度
 
 @param height 限定的高度
 @param fontSize 字体大小
 @return 宽度
 */
- (CGFloat)cz_getMaxWidthWithHeight:(CGFloat)height Font:(CGFloat)fontSize{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options: NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size.width;
}

/**
 获取最大的宽高
 
 @param width 限定的宽度
 @param height 限定的高度
 @param fontSize 字体大小
 @return 宽高
 */
- (CGSize)cz_getSizeWithWidth:(CGFloat)width Height:(CGFloat)height Font:(CGFloat)fontSize{
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, height) options: NSStringDrawingTruncatesLastVisibleLine |  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect.size;
}

/**
 *  截取字符串中的对应字节数字符
 *
 *  @param count 要截取出来的字节数
 *
 *  @return 截取后的字符串
 */
- (NSString *)cz_cutByteWithNSStingByeBytesCount:(int)count
{
    if (self.length == 0) return self;
    
    int k = 0;
    int j = 0;
    
    for(int i=0; i< [self length];i++){
        NSRange range = NSMakeRange(i, 1);
        
        NSString *subStr = [self substringWithRange:range];
        
        const char * cString = [subStr UTF8String];
        
        if (strlen(cString) == 3) {
            if (k+2 > count) {
                break;
            } else {
                k += 2;
            }
        } else {
            if (k+1 > count) {
                break;
            } else {
                k += 1;
            }
            
        }
        j = i;
    }
    
    NSString *newStr = [self substringWithRange:NSMakeRange(0, j + 1)];
    
    return newStr;
}


/**
 *  把手机号码中间几位显示为*****
 *
 *  @return 加密号码
 */
- (NSString *)cz_changeMobileNumber{
    NSMutableString *phoneText = [NSMutableString string];
    [phoneText appendString:self];
    [phoneText replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return [phoneText copy];
}

#pragma mark - 日期相关


/**
 /////  和当前时间比较
 ////   1）1分钟以内 显示        :    刚刚
 ////   2）1小时以内 显示        :    X分钟前
 ///    3）今天或者昨天 显示      :    今天 09:30   昨天 09:30
 ///    4) 今年显示              :   09月12日
 ///    5) 大于本年      显示    :    2013/09/09
 **/

- (NSString *)cz_getPastTimeStringWithFormate:(NSString *)formate
{
    
    @try {
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:formate];
        
        NSDate * nowDate = [NSDate date];
        
        /////  将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:self];
        /////  取当前时间和转换时间两个日期对象的时间间隔
        /////  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        
        //// 再然后，把间隔的秒数折算成天数和小时数：
        
        NSString *dateStr = @"";
        
        if (time<=60) {  //// 1分钟以内的
            dateStr = @"刚刚";
            
        }else if(time<=60*60){  ////  一个小时以内的
            
            int mins = time/60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
            
            
        }else if(time<=60*60*24){   //// 在两天内的
            
            [dateFormatter setDateFormat:@"YYYY/MM/dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }else{
                ////  昨天
                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }
        }else {
            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {
                ////  在同一年
                [dateFormatter setDateFormat:@"MM月dd日"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }else{
                [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
        
        return dateStr;
    }
    @catch (NSException *exception) {
        return @"";
    }
    
    
}

#pragma mark - 散列函数
- (NSString *)cz_md5String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)cz_sha1String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)cz_sha224String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA224_DIGEST_LENGTH];
    
    CC_SHA224(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA224_DIGEST_LENGTH];
}

- (NSString *)cz_sha256String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)cz_sha384String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA384_DIGEST_LENGTH];
    
    CC_SHA384(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA384_DIGEST_LENGTH];
}

- (NSString *)cz_sha512String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - HMAC 散列函数
- (NSString *)cz_hmacMD5StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgMD5, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)cz_hmacSHA1StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)cz_hmacSHA256StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)cz_hmacSHA512StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA512, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - 文件散列函数

#define FileHashDefaultChunkSizeForReadingData 4096

- (NSString *)cz_fileMD5Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_MD5_CTX hashCtx;
    CC_MD5_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_MD5_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)cz_fileSHA1Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA1_CTX hashCtx;
    CC_SHA1_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA1_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)cz_fileSHA256Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA256_CTX hashCtx;
    CC_SHA256_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA256_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)cz_fileSHA512Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }
    
    CC_SHA512_CTX hashCtx;
    CC_SHA512_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA512_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512_Final(buffer, &hashCtx);
    
    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - 助手方法
/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return strM.copy;
}

#pragma mark - BASE 64

/**
 对当前字符串进行 BASE 64 编码，并且返回结果
 
 @return BASE 64 编码字符串
 */
- (NSString *)cz_base64Encode{
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}


/**
 对当前字符串进行 BASE 64 解码，并且返回结果
 
 @return BASE 64 解码字符串
 */
- (NSString *)cz_base64Decode{
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
}



#pragma mark - Path路径
/**
 给当前文件追加文档路径
 */
- (NSString *)cz_appendDocumentDir{
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

/**
 给当前文件追加缓存路径
 */
- (NSString *)cz_appendCacheDir{
    NSString *dir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

/**
 给当前文件追加临时路径
 */
- (NSString *)cz_appendTempDir{
    NSString *dir = NSTemporaryDirectory();
    
    return [dir stringByAppendingPathComponent:self.lastPathComponent];
}

@end
