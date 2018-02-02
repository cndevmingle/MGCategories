#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSObject+MGCache.h"
#import "NSDate+MGDate.h"
#import "UIView+MGView.h"

FOUNDATION_EXPORT double MGCategoriesVersionNumber;
FOUNDATION_EXPORT const unsigned char MGCategoriesVersionString[];

