//
//  ViewController.m
//  JKRCategoryDemo
//
//  Created by Joker on 2018/11/3.
//  Copyright © 2018 Joker. All rights reserved.
//

#import "ViewController.h"
#import "NSString+JKRFilter.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    {
        NSString *test = @"98.01999";
        NSLog(@"%@ -> %@", test, [test jkr_filter_subNumberStringWithDecimals:2]);
    }
    {
        NSString *test = @"98.90999";
        NSLog(@"%@ -> %@", test, [test jkr_filter_subNumberStringWithDecimals:2]);
    }
    {
        NSString *test = @"123,456,789.01999";
        NSLog(@"%@ -> %@", test, [test jkr_filter_subNumberStringWithDecimals:2]);
    }
    {
        NSString *test = @"123,456,789.90999";
        NSLog(@"%@ -> %@", test, [test jkr_filter_subNumberStringWithDecimals:2]);
    }
    
    
    {
        NSString *test = @"98.012999";
        NSLog(@"%@ -> %@", test, [test jkr_filter_subNumberStringWithDecimals:3]);
    }
    {
        NSString *test = @"98.990999";
        NSLog(@"%@ -> %@", test, [test jkr_filter_subNumberStringWithDecimals:3]);
    }
    {
        NSString *test = @"123,456,789.012999";
        NSLog(@"%@ -> %@", test, [test jkr_filter_subNumberStringWithDecimals:3]);
    }
    {
        NSString *test = @"123,456,789.990999";
        NSLog(@"%@ -> %@", test, [test jkr_filter_subNumberStringWithDecimals:3]);
    }
    
}



@end
