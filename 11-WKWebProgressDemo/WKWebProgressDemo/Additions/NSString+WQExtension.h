//
//  NSString+WQExtension.h
//  TestAddtions
//
//  Created by 吴强 on 2017/4/27.
//  Copyright © 2017年 ChongqingWirelessOasisCommunicationTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (WQExtension)

#pragma mark - 判断和正则匹配

/**
 *  是否为电话号码
 */
- (BOOL)cz_isTelephoneNum;

/**
 是否为车牌号
 */
- (BOOL)cz_isLicenseNumber;

/**
 是否为邮箱格式
 */
- (BOOL)cz_isValidateEmail;
/**
 *  是否为身份证号15或18位
 */
- (BOOL)cz_isIdCard;
/**
 *  是否为邮编
 */
- (BOOL)cz_isZipCode;
/**
 *  是否为纯数字
 */
- (BOOL)cz_validateNumb;
/**
 *  是否为纯汉字
 */
- (BOOL)cz_isChineseText;
/**
 *  是否有值
 */
- (BOOL)cz_isNotNil;
/**
 *  判断是否为整形
 */
- (BOOL)cz_isPureInt;
/**
 *  判断是否为浮点形
 */
- (BOOL)cz_isPureFloat;
/**
 *  判断是否包含某字符串
 */
- (BOOL)cz_isContainsSubString:(NSString *)subString;


#pragma mark - 计算\处理
/**
 获取最大的高度

 @param width 限定的宽度
 @param fontSize 字体大小
 @return 高度
 */
- (CGFloat)cz_getMaxHeightWithWidth:(CGFloat)width Font:(CGFloat)fontSize;
/**
 获取最大的宽度
 
 @param height 限定的高度
 @param fontSize 字体大小
 @return 宽度
 */
- (CGFloat)cz_getMaxWidthWithHeight:(CGFloat)height Font:(CGFloat)fontSize;
/**
 获取最大的宽高

 @param width 限定的宽度
 @param height 限定的高度
 @param fontSize 字体大小
 @return 宽高
 */
- (CGSize)cz_getSizeWithWidth:(CGFloat)width Height:(CGFloat)height Font:(CGFloat)fontSize;


/**
 *  截取字符串中的对应字节数字符
 *
 *  @param count 要截取出来的字节数
 *
 *  @return 截取后的字符串
 */
- (NSString *)cz_cutByteWithNSStingByeBytesCount:(int)count;

/**
 *  把手机号码中间几位显示为*****
 *
 *  @return 加密号码
 */
- (NSString *)cz_changeMobileNumber;

#pragma mark - 日期相关

/**
 /////  和当前时间比较
 ////   1）1分钟以内 显示        :    刚刚
 ////   2）1小时以内 显示        :    X分钟前
 ///    3）今天或者昨天 显示      :    今天 09:30   昨天 09:30
 ///    4) 今年显示              :   09月12日
 ///    5) 大于本年      显示    :    2013/09/09
 **/

- (NSString *)cz_getPastTimeStringWithFormate:(NSString *)formate;


#pragma mark - 散列函数
/**
 *  计算MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 -s "string"
 *  @endcode
 *
 *  <p>提示：随着 MD5 碰撞生成器的出现，MD5 算法不应被用于任何软件完整性检查或代码签名的用途。<p>
 *
 *  @return 32个字符的MD5散列字符串
 */
- (NSString *)cz_md5String;

/**
 *  计算SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (NSString *)cz_sha1String;

/**
 *  计算SHA224散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha224
 *  @endcode
 *
 *  @return 56个字符的SHA224散列字符串
 */
- (NSString *)cz_sha224String;

/**
 *  计算SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (NSString *)cz_sha256String;

/**
 *  计算SHA 384散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha384
 *  @endcode
 *
 *  @return 96个字符的SHA 384散列字符串
 */
- (NSString *)cz_sha384String;

/**
 *  计算SHA 512散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512
 *  @endcode
 *
 *  @return 128个字符的SHA 512散列字符串
 */
- (NSString *)cz_sha512String;

#pragma mark - HMAC 散列函数
/**
 *  计算HMAC MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl dgst -md5 -hmac "key"
 *  @endcode
 *
 *  @return 32个字符的HMAC MD5散列字符串
 */
- (NSString *)cz_hmacMD5StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1 -hmac "key"
 *  @endcode
 *
 *  @return 40个字符的HMAC SHA1散列字符串
 */
- (NSString *)cz_hmacSHA1StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256 -hmac "key"
 *  @endcode
 *
 *  @return 64个字符的HMAC SHA256散列字符串
 */
- (NSString *)cz_hmacSHA256StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA512散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512 -hmac "key"
 *  @endcode
 *
 *  @return 128个字符的HMAC SHA512散列字符串
 */
- (NSString *)cz_hmacSHA512StringWithKey:(NSString *)key;

#pragma mark - 文件散列函数

/**
 *  计算文件的MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 file.dat
 *  @endcode
 *
 *  @return 32个字符的MD5散列字符串
 */
- (NSString *)cz_fileMD5Hash;

/**
 *  计算文件的SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha1 file.dat
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (NSString *)cz_fileSHA1Hash;

/**
 *  计算文件的SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha256 file.dat
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (NSString *)cz_fileSHA256Hash;

/**
 *  计算文件的SHA512散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha512 file.dat
 *  @endcode
 *
 *  @return 128个字符的SHA512散列字符串
 */
- (NSString *)cz_fileSHA512Hash;


#pragma mark - BASE 64 编码/解码

/**
 对当前字符串进行 BASE 64 编码，并且返回结果

 @return BASE 64 编码字符串
 */
- (NSString *)cz_base64Encode;


/**
 对当前字符串进行 BASE 64 解码，并且返回结果

 @return BASE 64 解码字符串
 */
- (NSString *)cz_base64Decode;


#pragma mark - Path路径
/**
 给当前文件追加文档路径
 */
- (NSString *)cz_appendDocumentDir;

/**
 给当前文件追加缓存路径
 */
- (NSString *)cz_appendCacheDir;

/**
 给当前文件追加临时路径
 */
- (NSString *)cz_appendTempDir;


@end
