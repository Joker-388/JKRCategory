//
//  JKRMusicViewController.m
//  MusicPlayerDemo
//
//  Created by Lucky on 15/10/8.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "JKRMusicViewController.h"
#import "MJExtension.h"
#import "JKRMusic.h"
#import "UIImage+Tool.h"
#import "JKRPlayingViewController.h"
#import "JKRMusicsTool.h"

@interface JKRMusicViewController ()

@property (nonatomic, strong) JKRPlayingViewController *playingViewController;

@end

@implementation JKRMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
}

- (JKRPlayingViewController *)playingViewController
{
    if (!_playingViewController) {
        _playingViewController = [[JKRPlayingViewController alloc] init];
    }
    return _playingViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [JKRMusicsTool musics].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CM = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CM];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CM];
    }
    
    JKRMusic *music = [JKRMusicsTool musics][indexPath.row];
    
    cell.imageView.image = [UIImage image:[UIImage imageNamed:music.singerIcon] withBorder:3 withColor:[UIColor redColor]];
    
    cell.textLabel.text = music.name;
    
    cell.detailTextLabel.text = music.singer;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [JKRMusicsTool setPlayingMusic:[JKRMusicsTool musics][indexPath.row]];
    [self.playingViewController show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
