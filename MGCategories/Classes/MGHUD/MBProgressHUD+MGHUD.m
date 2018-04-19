//
//  MBProgressHUD+MGHUD.m
//  MGHUD
//
//  Created by Mingle on 2018/4/19.
//  Copyright © 2018年 Mingle. All rights reserved.
//

#import "MBProgressHUD+MGHUD.h"

#ifndef mgKeyWindow
#define mgKeyWindow [[UIApplication sharedApplication] keyWindow]
#endif

#define kMGHUDShowTimeInterval 1.5f

static UIImage *kCorrectImage = nil;
static UIImage *kErrorImage   = nil;
static BOOL     kViewLock     = YES;

@implementation MBProgressHUD (MGHUD)

+ (void)mg_hideAnimated:(BOOL)animated {
    [[self HUDForView:mgKeyWindow] hideAnimated:animated];
}

+ (void)mg_hideForView:(UIView *)view animated:(BOOL)animated {
    [self hideHUDForView:view animated:animated];
}

+ (void)mg_hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    [[self HUDForView:mgKeyWindow] hideAnimated:animated afterDelay:delay];
}

+ (void)mg_showMessage:(NSString *)message hideDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:mgKeyWindow];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    [mgKeyWindow addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:delay];
    hud.userInteractionEnabled = kViewLock;
}

+ (void)mg_showMessage:(NSString *)message {
    [self mg_showMessage:message hideDelay:[self mg_getMessageShowsTime:message]];
}

+ (void)mg_showLoadingAnimated:(BOOL)animated {
    MBProgressHUD *hud = [self showHUDAddedTo:mgKeyWindow animated:animated];
    hud.userInteractionEnabled = kViewLock;
}

+ (void)mg_showLoadingWithView:(UIView *)view animated:(BOOL)animated {
    [self showHUDAddedTo:view animated:animated];
}

+ (void)mg_showLoadingMessage:(NSString *)message toView:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    [view addSubview:hud];
    [hud showAnimated:animated];
    hud.userInteractionEnabled = kViewLock;
}

+ (void)mg_showCorrectMessage:(NSString *)message {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:mgKeyWindow];
    hud.mode = MBProgressHUDModeCustomView;
    if (!kCorrectImage) {
        kCorrectImage = [UIImage imageWithContentsOfFile:[self mg_imagePathWithName:@"correct@2x"]];
    }
    UIImageView *imgView = [[UIImageView alloc] initWithImage:kCorrectImage];
    hud.customView = imgView;
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    [mgKeyWindow addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:kMGHUDShowTimeInterval];
    hud.userInteractionEnabled = kViewLock;
}

+ (void)mg_showErrorMessage:(NSString *)message {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:mgKeyWindow];
    hud.mode = MBProgressHUDModeCustomView;
    if (!kErrorImage) {
        kErrorImage = [UIImage imageWithContentsOfFile:[self mg_imagePathWithName:@"error@2x"]];
    }
    UIImageView *imgView = [[UIImageView alloc] initWithImage:kErrorImage];
    hud.customView = imgView;
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    [mgKeyWindow addSubview:hud];
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:kMGHUDShowTimeInterval];
    hud.userInteractionEnabled = kViewLock;
}

+ (void)mg_setCorrectImage:(UIImage *)image {
    kCorrectImage = image;
}

+ (void)mg_setErrorImage:(UIImage *)image {
    kErrorImage = image;
}

+ (void)mg_setViewLock:(BOOL)lock {
    kViewLock = lock;
}

+ (NSString *)mg_imagePathWithName:(NSString *)imageName {
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle bundleForClass:[self class]] URLForResource:@"MGHUD" withExtension:@"bundle"]];
    return [bundle pathForResource:imageName ofType:@"png"];
}

+ (NSTimeInterval)mg_getMessageShowsTime:(NSString *)message {
    NSTimeInterval duration = message.length * 0.1f + 1;
    if (message.length == 0) {
        duration = 0;
    } else if (duration > 3) {
        duration = 3;
    }
    return duration;
}

@end
