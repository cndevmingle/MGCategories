//
//  MBProgressHUD+MGHUD.h
//  MGHUD
//
//  Created by Mingle on 2018/4/19.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MGHUD)

/**
 设置hud显示时，底层view是否可响应，默认YES不可响应
 */
+ (void)mg_setViewLock:(BOOL)lock;

/**
 设置正确信息的图片
 */
+ (void)mg_setCorrectImage:(UIImage *)image;

/**
 设置错误信息图片
 */
+ (void)mg_setErrorImage:(UIImage *)image;

/**
 隐藏
 */
+ (void)mg_hideAnimated:(BOOL)animated;

/**
 隐藏指定视图上的HUD
 */
+ (void)mg_hideForView:(UIView *)view animated:(BOOL)animated;

/**
 延迟隐藏
 */
+ (void)mg_hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

/**
 显示一条文本消息
 */
+ (void)mg_showMessage:(NSString *)message;

/**
 显示文本信息一段时间
 */
+ (void)mg_showMessage:(NSString *)message hideDelay:(NSTimeInterval)delay;

/**
 只显示一个转圈的HUD
 */
+ (void)mg_showLoadingAnimated:(BOOL)animated;

/**
 在指定视图上转圈
 */
+ (void)mg_showLoadingWithView:(UIView *)view animated:(BOOL)animated;

/**
 显示加载信息和转圈动画
 */
+ (void)mg_showLoadingMessage:(NSString *)message toView:(UIView *)view animated:(BOOL)animated;

/**
 显示正确信息
 */
+ (void)mg_showCorrectMessage:(NSString *)message;

/**
 显示错误信息
 */
+ (void)mg_showErrorMessage:(NSString *)message;

@end
