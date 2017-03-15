//
//  AppDelegate+JKRWelcomeScreen.m
//  ZHYQ
//
//  Created by Joker on 14/5/15.
//  Copyright © 2014年 Joker. All rights reserved.
//

#import "AppDelegate+JKRWelcomeScreen.h"

@implementation AppDelegate (JKRWelcomeScreen)

- (void)jkr_configWelcomeScreen {
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"FIRST_START"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FIRST_START"];
        NSArray *arr =  @[[UIImage imageNamed:@"guide1.png"],[UIImage imageNamed:@"guide2.png"],[UIImage imageNamed:@"guide3.png"]];
        JKRWelcomeView *pageView = [[JKRWelcomeView alloc] initWithFrame:[UIScreen mainScreen].bounds WithImage:arr];
        [self.window.rootViewController.view addSubview:pageView];
    }
}

@end
