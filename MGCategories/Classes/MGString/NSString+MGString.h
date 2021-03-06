//
//  NSString+MGString.h
//  MGCategories
//
//  Created by Mingle on 2018/4/9.
//

#import <Foundation/Foundation.h>

@interface NSString (MGString)

/**
 判断是否是空

 @param str 对象
 @return 是否为空
 */
+ (BOOL)mg_isBlank:(NSString *)str;

/**
 手机号分服务商验证

 @return 验证电话号码
 */
- (BOOL)mg_isMobileNumberClassification;

/**
 手机号有效性
 */
- (BOOL)mg_isMobileNumber;

/**
 邮箱
 */
- (BOOL)mg_isEmailAddress;

/**
 身份证号
 */
- (BOOL)mg_simpleVerifyIdentityCardNum;

/**
 车牌验证
 */
- (BOOL)mg_isCarNumber;

/**
 mac地址验证
 */
- (BOOL)mg_isMacAddress;

/**
 URL地址验证
 */
- (BOOL)mg_isValidUrl;

/**
 验证是否是中文
 */
- (BOOL)mg_isValidChinese;

/**
 邮编验证
 */
- (BOOL)mg_isValidPostalcode;

- (BOOL)mg_isValidTaxNo;

/**
 字符串验证
 */
- (BOOL)mg_isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 字符串验证
 */
- (BOOL)mg_isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 精确的身份证号码有效性检测
 */
+ (BOOL)mg_accurateVerifyIDCardNumber:(NSString *)value;

/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
- (BOOL)mg_bankCardluhmCheck;

/**
 ip验证
 */
- (BOOL)mg_isIPAddress;

/**
 获取字符串大小

 @param font 字体
 @param maxSize 最大大小
 @return 实际大小
 */
- (CGSize)mg_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
