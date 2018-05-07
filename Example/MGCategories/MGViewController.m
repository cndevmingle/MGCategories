//
//  MGViewController.m
//  MGCategories
//
//  Created by Mingle on 01/31/2018.
//  Copyright (c) 2018 Mingle. All rights reserved.
//

#import "MGViewController.h"
#import <MGCategories/UIView+MGView.h>
#import <MGCategories/UIAlertController+MGAlert.h>

@interface MGViewController ()

@end

@implementation MGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [UIAlertAction mg_showAlertFromTarget:self title:@"-title" message:@"message-" buttonTitles:@[@"b0", @"b1", @"b2"] callback:^(NSString *selected) {
//        NSLog(@"%@", selected);
//    }];
    
//    [UIAlertAction mg_showActionSheetFromTarget:self title:@"-title" message:@"message-" buttonTitles:@[@"b0", @"b1", @"b2"] callback:^(NSString *selected) {
//        NSLog(@"%@", selected);
//    }];
    
//    [UIAlertAction mg_showAlertFromTarget:self title:@"-title" message:@"message-" buttons:@[@{@"普通按钮":kMGAlertActionStyleDefault,}, @{@"销毁按钮":kMGAlertActionStyleDestructive}, @{@"取消按钮":kMGAlertActionStyleCancel}, @{@"普通按钮":kMGAlertActionStyleDefault,}, @{@"销毁按钮":kMGAlertActionStyleDestructive}] callback:^(NSString *selected) {
//        NSLog(@"%@", selected);
//    }];
    
    [UIAlertController mg_showActionSheetFromTarget:self title:@"-title" message:@"message-" buttons:@[@{@"普通按钮":kMGAlertActionStyleDefault,}, @{@"销毁按钮":kMGAlertActionStyleDestructive}, @{@"取消按钮":kMGAlertActionStyleCancel}, @{@"普通按钮":kMGAlertActionStyleDefault,}, @{@"销毁按钮":kMGAlertActionStyleDestructive}] callback:^(NSString *selected) {
        NSLog(@"%@", selected);
    }];
}

- (void)gestureTestCase {
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 300, 300)];
    aView.backgroundColor = [UIColor redColor];
    [aView mg_whenTapOnceWithBlock:^(UIView *view) {
        NSLog(@"mg_whenTapOnceWithBlock");
    }];
    [aView mg_whenTapDoubleWithBlock:^(UIView *view) {
        NSLog(@"mg_whenTapDoubleWithBlock");
    }];
    [aView mg_whenLongPressWithBlock:^(UIView *view) {
        NSLog(@"mg_whenLongPressWithBlock");
    }];
    [self.view addSubview:aView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
