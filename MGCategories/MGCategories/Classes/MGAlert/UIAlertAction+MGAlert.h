//
//  UIAlertAction+MGAlert.h
//  MGCategories
//
//  Created by Mingle on 2018/4/14.
//

#import <UIKit/UIKit.h>

typedef NSString const* MGAlertActionStyle;

UIKIT_EXTERN MGAlertActionStyle kMGAlertActionStyleDefault;
UIKIT_EXTERN MGAlertActionStyle kMGAlertActionStyleCancel;
UIKIT_EXTERN MGAlertActionStyle kMGAlertActionStyleDestructive;


@interface UIAlertAction (MGAlert)

/**
 显示aler

 @param target          上级视图控制器
 @param title           标题
 @param message         内容
 @param buttonTitles    按钮标题
 @param callback        回调
 */
+ (void)mg_showAlertFromTarget:(UIViewController * _Nonnull)target
                         title:(NSString *)title
                       message:(NSString *)message
                  buttonTitles:(NSArray<NSString *> *)buttonTitles
                      callback:(void (^)(NSString *selected))callback;

/**
 显示aler
 
 @param target      上级视图控制器
 @param title       标题
 @param message     内容
 @param buttons     按钮
 @param callback    回调
 */
+ (void)mg_showAlertFromTarget:(UIViewController * _Nonnull)target
                         title:(NSString *)title
                       message:(NSString *)message
                  buttons:(NSArray<NSDictionary<NSString *, MGAlertActionStyle> *> *)buttons
                      callback:(void (^)(NSString *selected))callback;

/**
 显示actionSheet
 
 @param target          上级视图控制器
 @param title           标题
 @param message         内容
 @param buttonTitles    按钮标题
 @param callback        回调
 */
+ (void)mg_showActionSheetFromTarget:(UIViewController * _Nonnull)target
                               title:(NSString *)title
                             message:(NSString *)message
                        buttonTitles:(NSArray<NSString *> *)buttonTitles
                            callback:(void (^)(NSString *))callback;

/**
 显示actionSheet
 
 @param target          上级视图控制器
 @param title           标题
 @param message         内容
 @param buttons         按钮
 @param callback        回调
 */
+ (void)mg_showActionSheetFromTarget:(UIViewController * _Nonnull)target
                               title:(NSString *)title
                             message:(NSString *)message
                             buttons:(NSArray<NSDictionary<NSString *, MGAlertActionStyle> *> *)buttons
                            callback:(void (^)(NSString *))callback;

@end
