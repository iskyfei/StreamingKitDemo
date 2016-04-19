//
//  ViewController.h
//  Walle
//
//  Created by 飞 刘 on 16/4/11.
//  Copyright © 2016年 LeSpeech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZNSegmentedControl;

@interface ViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet DZNSegmentedControl *segmentedControl;

- (IBAction)didChangeSegment:(id)sender;
@end

