//
//  DXSemiViewController.h
//  DXSemiSideDemo
//

//

#import <UIKit/UIKit.h>

typedef enum {
    SemiViewControllerDirectionLeft,
    SemiViewControllerDirectionRight,
}SemiViewControllerDirection;

@interface DXSemiViewController : UIViewController

@property (nonatomic, assign) SemiViewControllerDirection direction;
@property (nonatomic, assign) CGFloat sideAnimationDuration;
@property (nonatomic, assign) CGFloat sideOffset;

@property (nonatomic, strong) UIView *contentView;


- (void)dismissSemi:(id)sender;

@end
