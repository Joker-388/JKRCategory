//
//  AppDelegate+JKRADPage.m
//  ZHYQ
//
//  Created by tronsis_ios on 17/3/15.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "AppDelegate+JKRADPage.h"

@implementation AppDelegate (JKRADPage)

- (void)jkr_configADPage {
    JKRADPage *adView = [[JKRADPage alloc] initWithFrame:self.window.bounds];
    [adView show];
}

@end
