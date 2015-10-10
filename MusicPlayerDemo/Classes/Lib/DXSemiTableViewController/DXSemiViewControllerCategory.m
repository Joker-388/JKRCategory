//
//  DXSemiViewControllerCategory.m
//  DXSemiSideDemo
//

//

#import "DXSemiViewControllerCategory.h"
#import "DXSemiViewController.h"

@implementation UIViewController (SemiViewController)

@dynamic leftSemiViewController;
@dynamic rightSemiViewController;


- (void)setLeftSemiViewController:(DXSemiViewController *)semiLeftVC
{
    [self setSemiViewController:semiLeftVC withDirection:SemiViewControllerDirectionLeft];
}

- (void)setRightSemiViewController:(DXSemiViewController *)semiRightVC
{
    [self setSemiViewController:semiRightVC withDirection:SemiViewControllerDirectionRight];
}

- (void)setSemiViewController:(DXSemiViewController *)semiVC withDirection:(SemiViewControllerDirection)direction
{
    semiVC.direction = direction;
    CGRect selfFrame = self.view.bounds;
    switch (direction) {
        case SemiViewControllerDirectionRight:
            selfFrame.origin.x += selfFrame.size.width;
            break;
        case SemiViewControllerDirectionLeft:
            selfFrame.origin.x -= selfFrame.size.width;
            break;
    }
    semiVC.view.frame = selfFrame;

/* overlayView if necessory */
/*
    UIView *overLayView = [[UIView alloc] initWithFrame:self.view.bounds];
    overLayView.backgroundColor = [UIColor blackColor];
    overLayView.alpha = 0.8;
    [self.view addSubview:overLayView];
*/
    
    [self.view addSubview:semiVC.view];
    [self addChildViewController:semiVC];
    [semiVC willMoveToParentViewController:self];
}


@end