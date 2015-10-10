//
//  DXSemiTableViewController.m
//  DXSemiSideDemo
//
#import "DXSemiTableViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DXSemiTableViewController ()

@end

@implementation DXSemiTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        self.titleLabelHeight = 14.0f;
        
        self.cellAnimationDuration = 0.7f;
        self.tableViewRowHeight = 44.0f;
        self.dateSourceArray = [NSMutableArray array];
        self.semiTitleLabel = [[UILabel alloc] init];
        self.semiTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.semiTableView = [[UITableView alloc] init];
        self.semiTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.semiTitleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), self.titleLabelHeight);
    self.semiTitleLabel.backgroundColor = [UIColor whiteColor];
    self.semiTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.semiTitleLabel];
    
//    self.semiTableView.backgroundColor = [UIColor blackColor];
    self.semiTableView.frame = CGRectMake(0, CGRectGetMaxY(self.semiTitleLabel.frame), CGRectGetWidth(self.contentView.bounds), CGRectGetHeight(self.contentView.bounds) - self.titleLabelHeight);
    [self.contentView addSubview:self.semiTableView];
    self.semiTableView.dataSource = self;
    self.semiTableView.delegate = self;
    self.semiTableView.rowHeight = self.tableViewRowHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section <= _currentMaxDisplayedSection && indexPath.row <= _currentMaxDisplayedCell) {
        return;
    }
    
    NSInteger baseRows = ceilf(CGRectGetHeight(self.semiTableView.bounds) / self.tableViewRowHeight) - 1;
    
    CGFloat delay = indexPath.row <= baseRows ? 0.05f * indexPath.row : 0.01f;
    
    switch (self.direction) {
        case SemiViewControllerDirectionRight: {
            cell.contentView.layer.transform = CATransform3DMakeRotation(90.0f, 0, 1, 0);
            cell.contentView.layer.anchorPoint = CGPointMake(1, 0.5);
        }
        break;
        case SemiViewControllerDirectionLeft: {
            cell.contentView.layer.transform = CATransform3DMakeRotation(-90.0f, 0, 1, 0);
            cell.contentView.layer.anchorPoint = CGPointMake(0.0, 0.5);
        }
    }

    [self.semiTableView bringSubviewToFront:cell.contentView];
    [UIView animateWithDuration:self.cellAnimationDuration
                          delay:delay
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         //clear the transform
                         cell.contentView.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0);
                     } completion:nil];
    _currentMaxDisplayedCell = indexPath.row;
    _currentMaxDisplayedSection = indexPath.section;
}

- (BOOL)isScreen568
{
    return CGRectGetHeight(self.view.bounds) - 480.0f > 0.1f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
