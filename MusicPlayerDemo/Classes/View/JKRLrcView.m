
//
//  JKRLrcView.m
//  MusicPlayerDemo
//
//  Created by Lucky on 15/10/9.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "JKRLrcView.h"

@interface JKRLrcView ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *timeArray;
@property (nonatomic, strong) NSMutableDictionary *LRCDictionary;

@property (nonatomic, assign) NSUInteger lrcLineNumber;

@end

@implementation JKRLrcView

+ (instancetype)lrcView
{
    return [[NSBundle mainBundle] loadNibNamed:@"JKRLrcView" owner:nil options:nil].firstObject;

}

- (void)awakeFromNib
{
    _timeArray = [[NSMutableArray alloc] initWithCapacity:10];
    _LRCDictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
    self.backgroundColor = [UIColor clearColor];
    self.hidden = YES;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 设置歌词数据
- (void)setLrcName:(NSString *)lrcName
{
    _lrcName = [lrcName copy];
    [self.timeArray removeAllObjects];
    [self.LRCDictionary removeAllObjects];
    [self.tableView reloadData];
    [self initLRC];
}

#pragma mark - 初始化lrc数据
- (void)initLRC {
    NSString *LRCPath = [[NSBundle mainBundle] pathForResource:_lrcName ofType:nil];
    NSLog(@"initLRC--%@--%@", _lrcName, LRCPath);
    NSString *contentStr = [NSString stringWithContentsOfFile:LRCPath encoding:NSUTF8StringEncoding error:nil];
    //    NSLog(@"contentStr = %@",contentStr);
    NSArray *array = [contentStr componentsSeparatedByString:@"\n"];
    for (int i = 0; i < [array count]; i++) {
        NSString *linStr = [array objectAtIndex:i];
        NSArray *lineArray = [linStr componentsSeparatedByString:@"]"];
        if ([lineArray[0] length] > 8) {
            NSString *str1 = [linStr substringWithRange:NSMakeRange(3, 1)];
            NSString *str2 = [linStr substringWithRange:NSMakeRange(6, 1)];
            if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."]) {
                NSString *lrcStr = [lineArray objectAtIndex:1];
                NSString *timeStr = [[lineArray objectAtIndex:0] substringWithRange:NSMakeRange(1, 5)];//分割区间求歌词时间
                //把时间 和 歌词 加入词典
                [_LRCDictionary setObject:lrcStr forKey:timeStr];
                [_timeArray addObject:timeStr];//timeArray的count就是行数
            }
        }
    }
}

#pragma mark - 根据当前播放进度，同步歌词位置
- (void)displaySondWord:(NSUInteger)time {
    NSLog(@"displaySondWord");
    //    NSLog(@"time = %u",time);
    for (int i = 0; i < [_timeArray count]; i++) {
        
        NSArray *array = [_timeArray[i] componentsSeparatedByString:@":"];//把时间转换成秒
        NSUInteger currentTime = [array[0] intValue] * 60 + [array[1] intValue];
        if (i == [_timeArray count]-1) {
            //求最后一句歌词的时间点
            NSArray *array1 = [_timeArray[_timeArray.count-1] componentsSeparatedByString:@":"];
            NSUInteger currentTime1 = [array1[0] intValue] * 60 + [array1[1] intValue];
            if (time > currentTime1) {
                [self updateLrcTableView:i];
                break;
            }
        } else {
            //求出第一句的时间点，在第一句显示前的时间内一直加载第一句
            NSArray *array2 = [_timeArray[0] componentsSeparatedByString:@":"];
            NSUInteger currentTime2 = [array2[0] intValue] * 60 + [array2[1] intValue];
            if (time < currentTime2) {
                [self updateLrcTableView:0];
                //                NSLog(@"马上到第一句");
                break;
            }
            //求出下一步的歌词时间点，然后计算区间
            NSArray *array3 = [_timeArray[i+1] componentsSeparatedByString:@":"];
            NSUInteger currentTime3 = [array3[0] intValue] * 60 + [array3[1] intValue];
            if (time >= currentTime && time <= currentTime3) {
                [self updateLrcTableView:i];
                break;
            }
            
        }
    }
}

#pragma mark － 动态更新歌词表歌词
- (void)updateLrcTableView:(NSUInteger)lineNumber {
    //重新载入 歌词列表lrcTabView
    _lrcLineNumber = lineNumber;
    [self.tableView reloadData];
    //使被选中的行移到中间
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lineNumber inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    //    NSLog(@"%i",lineNumber);
}

#pragma mark - tableView代理

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
        return [_timeArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_timeArray count];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"LRCCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//该表格选中后没有颜色
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == _lrcLineNumber) { //演唱中歌词的颜色设置
        cell.textLabel.text = _LRCDictionary[_timeArray[indexPath.row]];
        cell.textLabel.textColor = [UIColor colorWithRed:211/255.0 green:57/255.0 blue:3/255.0 alpha:1.0];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    } else {  //未演唱中歌词的颜色设置
        cell.textLabel.text = _LRCDictionary[_timeArray[indexPath.row]];
        cell.textLabel.textColor = [UIColor colorWithRed:211/255.0 green:57/255.0 blue:3/255.0 alpha:0.5];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
    }
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    //        [cell.contentView addSubview:lable];//往列表视图里加 label视图，然后自行布局
    return cell;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

#pragma mark - 显示歌词界面
- (void)show
{
    self.hidden = NO;
}

#pragma mark - 隐藏歌词界面
- (void)hide
{
    self.hidden = YES;
}

@end
