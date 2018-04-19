//
//  NSMutableAttributedString+MGString.m
//  MGCategories
//
//  Created by Mingle on 2018/4/9.
//

#import "NSMutableAttributedString+MGString.h"
#import <UIKit/UIKit.h>

@implementation NSMutableAttributedString (MGString)

- (void)setStyleWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color {
    NSRange range = [self.string rangeOfString:string];
    if (font) {
        [self setAttributes:@{NSFontAttributeName : font} range:range];
    }
    if (color) {
        [self setAttributes:@{NSForegroundColorAttributeName : color} range:range];
    }
}

@end
