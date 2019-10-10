//
//  ViewController.m
//  JKRCategoryDemo
//
//  Created by Joker on 2018/11/3.
//  Copyright © 2018 Joker. All rights reserved.
//

#import "ViewController.h"
#import "NSString+JKRFilter.h"
#import "UIImageView+JKRImagesAnimation.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray<UIImage *> *images;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

}

- (IBAction)start:(id)sender {
    [self.imageView jkr_startAnimationWithDuration:3 images:self.images completion:^(BOOL finished) {
        NSLog(@"finish");
    }];
}

- (IBAction)startRepeat:(id)sender {
    [self.imageView jkr_startRepeatAnimationWithDuration:3 images:self.images];
}

- (IBAction)stop:(id)sender {
    [self.imageView jkr_finishAnimation];
}

- (NSArray<UIImage *> *)images {
    if (!_images) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 1; i < 13; i++) {
            [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"ahud%zd", i]]];
        }
        _images = [NSArray arrayWithArray:array];
    }
    return _images;
}

@end
