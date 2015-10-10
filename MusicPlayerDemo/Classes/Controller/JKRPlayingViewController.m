//
//  JKRPlayingViewController.m
//  MusicPlayerDemo
//
//  Created by Lucky on 15/10/8.
//  Copyright © 2015年 Lucky. All rights reserved.
//

#import "JKRPlayingViewController.h"
#import "UIView+Extension.h"
#import "JKRMusicTool.h"
#import "JKRMusic.h"
#import "JKRMusicsTool.h"
#import <AVFoundation/AVFoundation.h>
#import "JKRLrcView.h"
#import "JKRMusicMenuViewController.h"

#import "DXSemiViewControllerCategory.h"

@interface JKRPlayingViewController ()<AVAudioPlayerDelegate, JKRMusicMenuViewControllerDelegate>

//* 当前正在播放的音乐 */
@property (nonatomic, strong) JKRMusic *playingMusic;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *songLabel;

@property (weak, nonatomic) IBOutlet UILabel *singerLabel;

@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

//* 进度条滑块 */
@property (weak, nonatomic) IBOutlet UIButton *slider;

//* 蓝色进度条 */
@property (weak, nonatomic) IBOutlet UIView *progressView;

//* 进度条背景点击手势 */
- (IBAction)progressBackGroundTap:(UITapGestureRecognizer *)sender;

//* 进度条滑块拉动手势 */
- (IBAction)slidePan:(UIPanGestureRecognizer *)sender;

//* 进度条拉动时上方的时间辅助显示 */
@property (weak, nonatomic) IBOutlet UIButton *currentTimeView;

//* 退出按钮 */
- (IBAction)exitBtnClick:(UIButton *)sender;

//* 播放／暂停按钮 */
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseButton;

- (IBAction)playOrPause:(UIButton *)sender;

- (IBAction)next:(UIButton *)sender;

- (IBAction)previous:(UIButton *)sender;

@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, strong) NSTimer *progressTimer;

- (void)addProgressTimer;

- (void)removeProgressTimer;

- (IBAction)lrcClick:(UIButton *)sender;

- (IBAction)musicListClick:(UIButton *)sender;


@property (nonatomic, strong) JKRLrcView *lrcView;

@property (weak, nonatomic) IBOutlet UIView *lrcBackGround;

@end

@implementation JKRPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.currentTimeView.layer.cornerRadius = 9;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 显示播放界面
- (void)show
{
    //显示播放界面，先判断选择的音乐和当前播放的是否相同，如果不同，则重置播放器
    if (self.playingMusic != [JKRMusicsTool playingMusic]) {
        [self resetPlayingMusic];
    }
    //获取keyWindow，并将播放界面显示在keyWindow上
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.userInteractionEnabled = NO; //弹出过程中，禁用交互，以防多次点击
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.hidden = NO;
    [self startPlayingMusic]; //开始播放音乐
    [window addSubview:self.view];
    self.view.y = [[UIScreen mainScreen] bounds].size.height;
    //以动画的形式弹出播放界面
    [UIView animateWithDuration:0.3 animations:^{
        self.view.y = 0;
    } completion:^(BOOL finished) {
        window.userInteractionEnabled = YES;
    }];
}

#pragma mark - 音乐播放
//* 重置播放器 */
- (void)resetPlayingMusic
{
    NSLog(@"reset play music");
    //重置界面
    self.singerLabel.text = nil;
    self.songLabel.text = nil;
    self.iconView.image = [UIImage imageNamed:@"play_cover_pic_bg"];
    //停止播放器
    [JKRMusicTool stopMusicWithFileName:self.playingMusic.filename];
    //关闭进度条定时器
    [self removeProgressTimer];
}

//* 开始播放音乐 */
- (void)startPlayingMusic
{
    NSLog(@"start play music");
    //获取当前要播放的音乐
    JKRMusic *music = [JKRMusicsTool playingMusic];
    //播放音乐，并获取播放器
    self.player = [JKRMusicTool playMusicWithFileName:music.filename];
    self.player.delegate = self;
    //将正在播放的音乐保存到变量中
    self.playingMusic = music;
    //设置界面
    self.iconView.image = [UIImage imageNamed:music.icon];
    
    self.songLabel.text = music.name;
    
    self.singerLabel.text = music.singer;
    
    self.durationLabel.text = [self stringWithTimeInterval:self.player.duration];
    //打开进度条定时器，更新进度条
    [self addProgressTimer];
    //设置播放／暂停按钮的状态
    self.playOrPauseButton.selected = YES;
    [self lrcClick:nil];
}

- (NSString *)stringWithTimeInterval:(NSTimeInterval)interval
{
    int m = interval / 60;
    int s = (int)interval % 60;
    return [NSString stringWithFormat:@"%d: %d", m, s];
}

#pragma mark - 进度条和歌词进度更新
//* 打开定时器 */
- (void)addProgressTimer
{
    NSLog(@"start timer");
    if (!self.player.playing) {
        return;
    }
    
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(updateCurrentProgress) userInfo:nil repeats:YES];
    
    //* 将更新进度条和歌词进度定时器加到默认运行循环，这样在滚动歌词的时候，就不会和更新进度相冲突 */
    [[NSRunLoop mainRunLoop] addTimer:self.progressTimer forMode:NSDefaultRunLoopMode];
}

//* 移除定时器 */
- (void)removeProgressTimer
{
    NSLog(@"remove timer");
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

//* 更新进度条进度 */
- (void)updateCurrentProgress
{
//    NSLog(@"update");
    double progress = self.player.currentTime / self.player.duration;
    
    self.slider.centerX = (self.view.width - self.slider.width)* progress + self.slider.width * 0.5;
    
    [self.slider setTitle:[self stringWithTimeInterval:self.player.currentTime] forState:UIControlStateNormal];
    
    self.progressView.width = self.slider.center.x;
    
    [_lrcView displaySondWord:self.player.currentTime];
}

#pragma mark - 进度条点击
- (IBAction)progressBackGroundTap:(UITapGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:sender.view];
    self.slider.centerX = point.x;
    
    double progress = (self.slider.centerX - self.slider.width * 0.5) / (self.slider.superview.width - self.slider.width);
    
    self.player.currentTime = progress * self.player.duration;
    [self updateCurrentProgress];
}

#pragma mark - 进度条滑动
- (IBAction)slidePan:(UIPanGestureRecognizer *)sender {
    //获取滑动距离
    CGPoint point = [sender translationInView:sender.view];
    //取消累加
    [sender setTranslation:CGPointZero inView:sender.view];
    //设置进度条滑块位置跟随滑动手势
    self.slider.x += point.x;
    //设置进度条长度跟随滑动手势
    self.progressView.width = self.slider.center.x;
    //计算音乐进度
    double progress = (self.slider.centerX - self.slider.width * 0.5) / (self.slider.superview.width - self.slider.width);
    //进度条滑动数据纠错
    if (progress < 0) {  //如果滑动进度为负（进度条左滑到屏幕外边缘），就纠正进度为0
        self.slider.x = 0;
        progress = 0;
    }
    
    if (progress > 1) { //如果滑动进度大于1（进度条右滑动到屏幕外边缘），就纠正进度为1
        self.slider.x = self.slider.superview.width - self.slider.width;
        progress = 1;
    }
    //设置进度条滑块时间
    [self.slider setTitle:[self stringWithTimeInterval:progress * self.player.duration] forState:UIControlStateNormal];
    //设置进度条上方辅助显示时间
    [self.currentTimeView setTitle:[self stringWithTimeInterval:progress * self.player.duration] forState:UIControlStateNormal];
    //设置辅助显示位置跟随手势
    self.currentTimeView.centerX = self.slider.centerX;
    
    self.currentTimeView.y = self.currentTimeView.superview.height - self.currentTimeView.height - 10;
    //开始滑动时，关闭进度条定时器，如果不关闭，就会出现滑动进度条的时候，进度条又因为定时器同步歌曲进度后，把进度条拉回去的情况
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        self.currentTimeView.hidden = NO;
        
        [self removeProgressTimer];
    }else if(sender.state == UIGestureRecognizerStateEnded) { //滑动结束后，重新定位音乐播放进度
        //如果正在播放状态，重新开启进度条定时器
        if (self.player.isPlaying) {
            [self addProgressTimer];
        }
        
        self.player.currentTime = progress * self.player.duration;
        //隐藏辅助显示
        self.currentTimeView.hidden = YES;
    }
}

#pragma mark - 退出播放界面
- (IBAction)exitBtnClick:(UIButton *)sender {
    [self removeProgressTimer];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.view.y = [[UIScreen mainScreen] bounds].size.height;
    } completion:^(BOOL finished) {
        window.userInteractionEnabled = YES;
        self.view.hidden = YES;
    }];
}

#pragma mark - 操作面板
//* 播放／暂停 */
- (IBAction)playOrPause:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.player play];
        [self addProgressTimer];
    }else{
        [self.player pause];
        [self removeProgressTimer];
    }
}

//* 下一曲 */
- (IBAction)next:(UIButton *)sender {
    [self resetPlayingMusic];
    [JKRMusicsTool setPlayingMusic:[JKRMusicsTool nextMusic]];
    [self startPlayingMusic];
    [self lrcClick:nil];
}

//* 上一曲 */
- (IBAction)previous:(UIButton *)sender {
    [self resetPlayingMusic];
    [JKRMusicsTool setPlayingMusic:[JKRMusicsTool previousMusic]];
    [self startPlayingMusic];
    [self lrcClick:nil];
}

#pragma mark - 播放器代理
//* 播放结束 */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //播放结束，自动播放下一曲
    [self next:nil];
}

//* 播放被打断的时候调用，来电等事件发生的时候，暂停音乐 */
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    if (self.player.playing) {
        [self playOrPause:self.playOrPauseButton];
    }
}

//* 播放打断结束后调用 */
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
    
}

#pragma mark - 显示歌词
//* 点击显示歌词按钮后显示歌词 */
- (IBAction)lrcClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.lrcView.lrcName = [JKRMusicsTool playingMusic].lrcname;
    if (!sender) {
        return;
    }
    if (sender.selected) {
        [self.lrcView show];
    }else{
        [self.lrcView hide];
    }
    NSLog(@"%@", self.lrcView);
}

//* 当前控制器歌词view的懒加载 */
- (JKRLrcView *)lrcView
{
    /** 
     这里学习了http://code4app.com/ios/527ef0516803fa537d000003代码里边的歌词显示方法
     将相关的部分单独抽取了一个View用来做歌词显示
     使用方法：
     1.创建view：_lrcView = [JKRLrcView lrcView]
     2.将view加到当前控制器里边：[self.lrcBackGround addSubview:_lrcView]
     3.设置lrc文件名：_lrcView.lrcName = (Bundle本地的文件名)
     4.显示／隐藏view：[self.lrcView show]／[self.lrcView hide]（默认新建后隐藏）
     */
    
    if (!_lrcView) {
        _lrcView = [JKRLrcView lrcView];
        _lrcView.frame = self.lrcBackGround.bounds;
        [self.lrcBackGround addSubview:_lrcView];
    }
   
    return _lrcView;
}

#pragma mark - 歌曲列表
//* 显示歌曲列表 */
- (IBAction)musicListClick:(UIButton *)sender {
    /**
     这里使用了一个意外发现的框架，用于便捷的显示一个cell加载自上而下有延迟动画的tableView
     框架来源是学习了http://code4app.com/ios/527ef0516803fa537d000003代码里边的歌曲菜单显示方法
     因为这个框架可以便捷的让tableView显示出来（只需要import框架的分类，然后self.rightSemiViewController就可以了）
     还能够自动在点击界面的时候自己隐藏，不需要额外控制，所以这里就使用了这个，省去了很多麻烦
     
     使用方法：
     1.将DXSemiTableViewController引入到项目中
     2.自定义一个tableView继承自DXSemiTableViewController，这个就是要显示的tableView
     3.当前控制器import分类：DXSemiViewControllerCategory.h
     4.在这里，创建控制器
     5.显示tableView，调用方法：self.rightSemiViewController = ...
     */
    JKRMusicMenuViewController *musicViewController = [[JKRMusicMenuViewController alloc] init];
    musicViewController.semiTitleLabel.text = @"";
    musicViewController.delegate = self;
    self.rightSemiViewController = musicViewController;
}

//* 歌曲列表选择歌曲后的回调 */
- (void)musicMenuViewController:(JKRMusicMenuViewController *)musicMenuViewController didSelectedMusic:(JKRMusic *)music
{
    //显示播放界面，先判断选择的音乐和当前播放的是否相同，如果不同，则重置播放器
    if (self.playingMusic != [JKRMusicsTool playingMusic]) {
        [self resetPlayingMusic];
    }
    
    [self startPlayingMusic]; //开始播放音乐
}

@end
