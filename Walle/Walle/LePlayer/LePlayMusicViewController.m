//
//  LePlayMusicViewController.m
//  Walle
//
//  Created by 飞 刘 on 16/4/18.
//  Copyright © 2016年 LeSpeech. All rights reserved.
//

#import "LePlayMusicViewController.h"
#import "LeAudioPlayer.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Blur.h"

@interface LePlayMusicViewController ()

@property (nonatomic) IBOutlet UILabel* progressLbl;
@property (nonatomic) IBOutlet UILabel* durationLbl;
@property (nonatomic) IBOutlet UISlider* progressSlider;
@property (nonatomic) IBOutlet UIButton* playBtn;
@property (nonatomic) IBOutlet UIImageView* thumbnailView;

@property (nonatomic) IBOutlet UIImageView* backgroundImageView;

@property (nonatomic) IBOutlet UILabel* mediaTitle;

@property (nonatomic) NSTimer *myTimer;

@property (nonatomic,retain)CABasicAnimation *basicAnimation;

@end

@implementation LePlayMusicViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGFloat width = self.thumbnailView.bounds.size.width;
    self.thumbnailView.layer.cornerRadius = width/2;
    self.thumbnailView.layer.masksToBounds = YES;
    self.thumbnailView.layer.borderWidth = 2;
    self.thumbnailView.layer.borderColor = [UIColor grayColor].CGColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(musicPlayHandler:) name:LE_PLAYER_STARTPLAY object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.myTimer) {
        [self.myTimer invalidate];
        self.myTimer = nil;
    }
    
    if (self.basicAnimation) {
        [self.thumbnailView.layer removeAllAnimations];
        self.basicAnimation = nil;
    }
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    LeAudioPlayer * lePlayer = [LeAudioPlayer player];
    if ((lePlayer.playStatus & STKAudioPlayerStateRunning) && lePlayer.playStatus != STKAudioPlayerStatePaused){
        [self.thumbnailView.layer removeAllAnimations];
        self.basicAnimation = nil;
        [self basicAnimation];
        [self musicPlayHandler:nil];
    }
    [self updateUIIamge];
}

-(void) musicPlayHandler:(NSNotification *) notification{
    if (!self.myTimer) {
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updatePlayPanel) userInfo:nil repeats:YES];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *  playBtnTxt = @"\U0000E964";
        
        [self.playBtn setTitle:playBtnTxt forState:UIControlStateNormal];
        
        [self.thumbnailView.layer removeAllAnimations];
        self.basicAnimation = nil;
        [self basicAnimation];
        
        [self updateUIIamge];
        
    });
}

-(void) updateUIIamge{
    LeAudioPlayer * lePlayer = [LeAudioPlayer player];
    __weak __typeof(self) weakSelf = self;
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:lePlayer.currentMedia.coverLarge] placeholderImage:[UIImage imageNamed:@"PlayerDefaultBG"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        image  = [image boxblurImageWithBlur:0.8];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.backgroundImageView setImage:image];
        });
    }];
    
    [self.thumbnailView sd_setImageWithURL:[NSURL URLWithString:lePlayer.currentMedia.coverSmall] placeholderImage:[UIImage imageNamed:@"PlayerDefualtIcon"]];
}

-(void) updatePlayPanel{
    LeAudioPlayer * lePlayer = [LeAudioPlayer player];
    
    NSString * title = lePlayer.currentMedia.title;
//    NSString * description = lePlayer.currentMedia.albumTitle;
    
    double duration = lePlayer.duration;
    double progress = lePlayer.progress;
    
    //当前时长进度progress
    NSInteger proMin = (NSInteger)progress / 60;//当前秒
    NSInteger proSec = (NSInteger)progress % 60;//当前分钟
    
    //duration 总时长
    NSInteger durMin = (NSInteger)duration / 60;//总秒
    NSInteger durSec = (NSInteger)duration % 60;//总分钟

    NSString * playBtnTxt = nil;
    
    if (!(lePlayer.playStatus & STKAudioPlayerStateRunning) || lePlayer.playStatus == STKAudioPlayerStatePaused) {
        [self.myTimer invalidate];
        self.myTimer = nil;
        [self.thumbnailView.layer removeAllAnimations];
        self.basicAnimation = nil;
        playBtnTxt =  @"\U0000E963";
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mediaTitle.text = title;
//        self.mediaDesc = description;
        
        self.durationLbl.text = [NSString stringWithFormat:@"%02ld:%02ld", durMin, durSec];
        self.progressLbl.text = [NSString stringWithFormat:@"%02ld:%02ld", proMin, proSec];
        
        self.progressSlider.maximumValue = duration;//音乐总共时长
        self.progressSlider.value = progress;//当前进度
        
        
        if (playBtnTxt) {
            [self.playBtn setTitle:playBtnTxt forState:UIControlStateNormal];
        }
        
    });
}


- (CABasicAnimation *)basicAnimation {
    if (_basicAnimation == nil) {
        self.basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //旋转一圈时长
        self.basicAnimation.duration = 30;
        //开始动画的起始位置
        self.basicAnimation.fromValue = [NSNumber numberWithInt:0];
        //M_PI是180度
        self.basicAnimation.toValue = [NSNumber numberWithInt:M_PI*2];
        //动画重复次数
        [self.basicAnimation setRepeatCount:NSIntegerMax];
        //播放完毕之后是否逆向回到原来位置
        [self.basicAnimation setAutoreverses:NO];
        //是否叠加（追加）动画效果
        [self.basicAnimation setCumulative:YES];
        //停止动画，速度设置为0
        self.thumbnailView.layer.speed = 1;
        //    self.ImageView.layer.speed = 0;
        [self.thumbnailView.layer addAnimation:self.basicAnimation forKey:@"basicAnimation"];
        
    }
    return _basicAnimation;
}



-(IBAction)playClick:(id)sender{
    [[LeAudioPlayer player] play];
}

-(IBAction)backClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)lastClick:(id)sender{
    [[LeAudioPlayer player] playNext];
}

-(IBAction)nextClick:(id)sender{
    [[LeAudioPlayer player] playLast];
}

@end
