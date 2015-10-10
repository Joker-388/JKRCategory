//
//  JKRMusicMenuViewController.m
//  MusicPlayerDemo
//
//  Created by Lucky on 15/10/10.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "JKRMusicMenuViewController.h"
#import "JKRMusicsTool.h"
#import "JKRMusic.h"

#import "UIView+Extension.h"

@interface JKRMusicMenuViewController ()

@end

@implementation JKRMusicMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.semiTableView.alpha = 0.6;
    self.semiTitleLabel.alpha = 0.0;
    
    self.semiTableView.height -= 20;

    self.semiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.semiTableView.y = 20;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [JKRMusicsTool musics].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CM = @"MMCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CM];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CM];
    }
    
    JKRMusic *music = [JKRMusicsTool musics][indexPath.row];
    
    cell.textLabel.text = music.name;
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.textLabel.textColor = [UIColor orangeColor];
    
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [JKRMusicsTool setPlayingMusic:[JKRMusicsTool musics][indexPath.row]];
    if ([self.delegate respondsToSelector:@selector(musicMenuViewController:didSelectedMusic:)]) {
        [self.delegate musicMenuViewController:self didSelectedMusic:[JKRMusicsTool playingMusic]];
    }
    [self dismissSemi:nil];
}

@end
