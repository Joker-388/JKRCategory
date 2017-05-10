//
//  UINavigationController+JKRBackButton.m
//  BaoJiDianJing
//
//  Created by Lucky on 2017/5/5.
//  Copyright © 2017年 KaiHei. All rights reserved.
//

#import "UINavigationController+JKRBackButton.h"

@interface UINavigationController ()

@property (nonatomic, strong) id popDelegate;

@end

@implementation UINavigationController (JKRBackButton)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([UINavigationController class], @selector(initWithRootViewController:)), class_getInstanceMethod([UINavigationController class], @selector(initWithRootViewControllerCustom:)));
    method_exchangeImplementations(class_getInstanceMethod([UINavigationController class], @selector(pushViewController:animated:)), class_getInstanceMethod([UINavigationController class], @selector(jkr_pushViewController:animated:)));
}

- (instancetype)initWithRootViewControllerCustom:(UIViewController *)rootViewController {
    self = [self initWithRootViewControllerCustom:rootViewController];
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = (id<UINavigationControllerDelegate>)self;
    return self;
}

- (void)setPopDelegate:(id)popDelegate {
    objc_setAssociatedObject(self, "jkr_pop_delegate", popDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id)popDelegate {
    return objc_getAssociatedObject(self, "jkr_pop_delegate");
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.interactivePopGestureRecognizer.delegate =  viewController == self.viewControllers[0]? self.popDelegate : nil;
}

- (void)jkr_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count == 1) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_fh"] style:UIBarButtonItemStyleDone target:self action:@selector(popController)];
    }
    [self jkr_pushViewController:viewController animated:YES];
}

- (void)popController {
    [self popViewControllerAnimated:YES];
}

@end
