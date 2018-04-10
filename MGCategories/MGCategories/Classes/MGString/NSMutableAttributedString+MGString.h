//
//  NSMutableAttributedString+MGString.h
//  MGCategories
//
//  Created by Mingle on 2018/4/9.
//

#import <Foundation/Foundation.h>

@class UIFont, UIColor;
@interface NSMutableAttributedString (MGString)

/**
 设置样式

 @param string 要更改样式的字符串
 @param font 字体
 @param color 颜色
 */
- (void)setStyleWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;

@end
