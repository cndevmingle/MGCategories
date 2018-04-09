//
//  MGViewController.m
//  MGCategories
//
//  Created by Mingle on 01/31/2018.
//  Copyright (c) 2018 Mingle. All rights reserved.
//

#import "MGViewController.h"
//#import <MGCategories/UIView+MGView.h>
#import "UIView+MGView.h"

@interface MGViewController ()

@end

@implementation MGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
