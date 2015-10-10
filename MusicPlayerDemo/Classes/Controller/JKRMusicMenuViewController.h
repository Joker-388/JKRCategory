//
//  JKRMusicMenuViewController.h
//  MusicPlayerDemo
//
//  Created by Lucky on 15/10/10.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "DXSemiTableViewController.h"
@class JKRMusicMenuViewController;
@class JKRMusic;

@protocol JKRMusicMenuViewControllerDelegate <NSObject>

@optional
- (void)musicMenuViewController:(JKRMusicMenuViewController *)musicMenuViewController didSelectedMusic:(JKRMusic *)music;

@end

@interface JKRMusicMenuViewController : DXSemiTableViewController

@property (nonatomic, weak) id<JKRMusicMenuViewControllerDelegate> delegate;

@end
