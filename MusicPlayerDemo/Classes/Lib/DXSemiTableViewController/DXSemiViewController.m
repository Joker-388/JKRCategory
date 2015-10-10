//
//  DXSemiViewController.m
//  DXSemiSideDemo
//

//

#import "DXSemiViewController.h"

@interface DXSemiViewController ()

@end

@implementation DXSemiViewController

- (id)init
{
    if (self = [super init]) {
        self.sideAnimationDuration = 0.3f;
        self.sideOffset = 50.0f;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    UIView *anotherView = [[UIView alloc] init];
    anotherView.backgroundColor = [UIColor clearColor];
    anotherView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSemi:)];

    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSemi:)];
    
    CGRect selfViewFrame = self.view.bounds;
    if (self.direction == SemiViewControllerDirectionLeft) {
        selfViewFrame.size.width = CGRectGetWidth(selfViewFrame) - self.sideOffset;
        self.contentView.frame = selfViewFrame;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        anotherView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        
        selfViewFrame.size.width = self.sideOffset;
        selfViewFrame.origin.x = CGRectGetMaxX(self.contentView.frame);
        anotherView.frame = selfViewFrame;
        
        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        
    }else if (self.direction == SemiViewControllerDirectionRight) {
        selfViewFrame.size.width = CGRectGetWidth(selfViewFrame) - self.sideOffset;
        selfViewFrame.origin.x = self.sideOffset;
        self.contentView.frame = selfViewFrame;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;

        
        selfViewFrame.origin.x = CGRectGetMinX(self.view.bounds);
        selfViewFrame.size.width = self.sideOffset;
        anotherView.frame = selfViewFrame;
        
        swipe.direction = UISwipeGestureRecognizerDirectionRight;
    }
    
    [self.view addSubview:self.contentView];
    [self.view addSubview:anotherView];
    [anotherView addGestureRecognizer:tap];
    [self.view addGestureRecognizer:swipe];
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{    
    [UIView animateWithDuration:self.sideAnimationDuration animations:^{
        CGRect selfViewFrame = self.view.frame;
        selfViewFrame.origin.x = 0.0f;
        self.view.frame = selfViewFrame;
    } completion:^(BOOL finished) {
        [super willMoveToParentViewController:parent];
    }];
}

- (void)dismissSemi:(id)sender
{
    [self willMoveToParentViewController:nil];
    CGRect pareViewRect = self.parentViewController.view.bounds;
    CGFloat originX = 0;

    switch (self.direction) {
        case SemiViewControllerDirectionLeft:
            originX -= CGRectGetWidth(pareViewRect);
            break;
        case SemiViewControllerDirectionRight:
            originX += CGRectGetWidth(pareViewRect);
    }
    
    [UIView animateWithDuration:self.sideAnimationDuration animations:^{
        self.view.frame = CGRectMake(originX, CGRectGetMinY(pareViewRect), CGRectGetWidth(pareViewRect), CGRectGetHeight(pareViewRect));
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
    [self removeFromParentViewController];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
