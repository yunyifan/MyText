//
//  VideoPlayViewController.m
//  IRDVideo
//
//  Created by 貟一凡 on 2017/4/1.
//  Copyright © 2017年 貟一凡. All rights reserved.
//

#import "VideoPlayViewController.h"
#import "WMPlayer.h"
@interface VideoPlayViewController ()<WMPlayerDelegate>


@property (nonatomic,strong)WMPlayer *player;
@end

@implementation VideoPlayViewController
-(void)viewWillDisappear:(BOOL)animated{

    [self releaseWMPlayer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.player = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 64, DEF_SCREEN_WIDTH, ViewHeight(300))];
    self.player.delegate = self;
    self.player.closeBtnStyle = CloseBtnStyleClose;
    self.player.URLString = @"http://weibo.com/tv/v/ED5iRy1Q1?from=music";
    [self.view addSubview:self.player];
    [self.player play];

}
- (void)releaseWMPlayer
{
    //堵塞主线程
    //    [wmPlayer.player.currentItem cancelPendingSeeks];
    //    [wmPlayer.player.currentItem.asset cancelLoading];
    [self.player pause];
    [self.player removeFromSuperview];
    [self.player.playerLayer removeFromSuperlayer];
    [self.player.player replaceCurrentItemWithPlayerItem:nil];
    self.player.player = nil;
    self.player.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [self.player.autoDismissTimer invalidate];
    self.player.autoDismissTimer = nil;
    self.player.playOrPauseBtn = nil;
    self.player.playerLayer = nil;
    self.player = nil;
}

// 播放器事件
- (void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn {
    
    [self releaseWMPlayer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
