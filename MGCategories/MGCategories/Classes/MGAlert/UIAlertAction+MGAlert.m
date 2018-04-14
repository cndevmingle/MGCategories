//
//  UIAlertAction+MGAlert.m
//  MGCategories
//
//  Created by Mingle on 2018/4/14.
//

#import "UIAlertAction+MGAlert.h"

MGAlertActionStyle const kMGAlertActionStyleDefault     = @"kMGAlertActionStyleDefault";
MGAlertActionStyle const kMGAlertActionStyleCancel      = @"kMGAlertActionStyleCancel";
MGAlertActionStyle const kMGAlertActionStyleDestructive = @"kMGAlertActionStyleDestructive";

@implementation UIAlertAction (MGAlert)

+ (void)mg_showAlertFromTarget:(UIViewController *)target
                         title:(NSString *)title
                       message:(NSString *)message
                  buttonTitles:(NSArray<NSString *> *)buttonTitles
                      callback:(void (^)(NSString *))callback {
    NSMutableArray<NSDictionary<NSString *, MGAlertActionStyle> *> *buttons = [NSMutableArray arrayWithCapacity:buttonTitles.count];
    for (int i = 0; i < buttonTitles.count; i++) {
        [buttons addObject:@{buttonTitles[i]:kMGAlertActionStyleDefault}];
    }
    [self mg_showFromTarget:target title:title message:message preferredStyle:UIAlertControllerStyleAlert buttons:buttons callback:callback];
}

+ (void)mg_showAlertFromTarget:(UIViewController *)target
                         title:(NSString *)title
                       message:(NSString *)message
                       buttons:(NSArray<NSDictionary<NSString *,MGAlertActionStyle> *> *)buttons
                      callback:(void (^)(NSString *))callback {
    [self mg_showFromTarget:target title:title message:message preferredStyle:UIAlertControllerStyleAlert buttons:buttons callback:callback];
}

+ (void)mg_showActionSheetFromTarget:(UIViewController *)target
                               title:(NSString *)title
                             message:(NSString *)message
                        buttonTitles:(NSArray<NSString *> *)buttonTitles
                            callback:(void (^)(NSString *))callback {
    NSMutableArray<NSDictionary<NSString *, MGAlertActionStyle> *> *buttons = [NSMutableArray arrayWithCapacity:buttonTitles.count];
    for (int i = 0; i < buttonTitles.count; i++) {
        [buttons addObject:@{buttonTitles[i]:kMGAlertActionStyleDefault}];
    }
    [self mg_showFromTarget:target title:title message:message preferredStyle:UIAlertControllerStyleActionSheet buttons:buttons callback:callback];
}

+ (void)mg_showActionSheetFromTarget:(UIViewController *)target
                               title:(NSString *)title
                             message:(NSString *)message
                             buttons:(NSArray<NSDictionary<NSString *,MGAlertActionStyle> *> *)buttons
                            callback:(void (^)(NSString *))callback {
    [self mg_showFromTarget:target title:title message:message preferredStyle:UIAlertControllerStyleActionSheet buttons:buttons callback:callback];
}

+ (void)mg_showFromTarget:(UIViewController *)target
                    title:(NSString *)title
                  message:(NSString *)message
           preferredStyle:(UIAlertControllerStyle)preferredStyle
                  buttons:(NSArray<NSDictionary<NSString *, MGAlertActionStyle> *> *)buttons
                 callback:(void (^)(NSString *))callback {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    for (int i = 0; i < buttons.count; i++) {
        NSDictionary<NSString *, MGAlertActionStyle> *button = buttons[i];
        UIAlertActionStyle actionStyle = [self alertActionStyleWithButtonStyle:button.allValues[0]];
        NSString *actionTitle = button.allKeys[0];
        [alert addAction:[UIAlertAction actionWithTitle:actionTitle style:actionStyle handler:^(UIAlertAction * _Nonnull action) {
            if (callback) {
                callback(action.title);
            }
        }]];
    }
    [target presentViewController:alert animated:YES completion:nil];
}

+ (UIAlertActionStyle)alertActionStyleWithButtonStyle:(MGAlertActionStyle)btnStyle {
    if ([btnStyle isEqualToString:kMGAlertActionStyleCancel]) {
        return UIAlertActionStyleCancel;
    } else if ([btnStyle isEqualToString:kMGAlertActionStyleDestructive]) {
        return UIAlertActionStyleDestructive;
    } else {
        return UIAlertActionStyleDefault;
    }
}

@end
