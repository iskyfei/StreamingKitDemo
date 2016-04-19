//
//  LeMyChannelView.m
//  Walle
//
//  Created by 飞 刘 on 16/4/12.
//  Copyright © 2016年 LeSpeech. All rights reserved.
//

#import "LeMyChannelView.h"
#import "LePlayBarView.h"

@interface LeMyChannelView ()<LePlayCommand>

@property (nonatomic) IBOutlet LePlayBarView* playbar;
@property (nonatomic) IBOutlet UILabel* titleLabel;

@end

@implementation LeMyChannelView


-(void)dealloc{
    self.playbar.playDelegate = nil;
}

-(void) willMoveToWindow:(UIWindow *)newWindow{
    self.playbar.playDelegate = self;
}

-(void) setTitle:(NSString *)title{
    [self.titleLabel setText:title];
    
    [self.playbar setMediaName:title];
}

@end
