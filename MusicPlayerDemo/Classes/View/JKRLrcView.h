//
//  JKRLrcView.h
//  MusicPlayerDemo
//
//  Created by Lucky on 15/10/9.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKRLrcView : UIView

@property (nonatomic, copy) NSString *lrcName;

+ (instancetype)lrcView;

- (void)displaySondWord:(NSUInteger)time;

- (void)show;

- (void)hide;

@end
