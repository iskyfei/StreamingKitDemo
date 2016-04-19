//
//  ViewController.m
//  Walle
//
//  Created by 飞 刘 on 16/4/11.
//  Copyright © 2016年 LeSpeech. All rights reserved.
//

#import "ViewController.h"
#import "DZNSegmentedControl.h"
#import "UIScrollView+DZNSegmentedControl.h"



#import "LeMyChannelView.h"
#import "LeTestMusicView.h"


@interface ViewController ()<DZNSegmentedControlDelegate>

@property (nonatomic) IBOutlet UIView* segment1View;
@property (nonatomic) IBOutlet UIView* segment2View;
@property (nonatomic) IBOutlet UIView* segment3View;

@end

@implementation ViewController

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    self.title = NSStringFromClass([DZNSegmentedControl class]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.segmentedControl.items = @[NSLocalizedString(@"tab_MyChannel", @"我的"),
                                    NSLocalizedString(@"tab_Discovery", @"发现"),
                                    NSLocalizedString(@"tab_VoiceBox", @"音箱")];
    self.segmentedControl.showsCount = NO;
    self.segmentedControl.autoAdjustSelectionIndicatorWidth = NO;
    self.segmentedControl.font = [UIFont systemFontOfSize:20];
  //  self.segmentedControl.height = 30;
    self.segmentedControl.delegate = self;


    self.scrollView.segmentedControl = self.segmentedControl;
    self.scrollView.scrollDirection = DZNScrollDirectionHorizontal;
    self.scrollView.scrollOnSegmentChange = YES;
    
    [self loadSubViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.clipsToBounds = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}



-(void) loadSubViews{
//    LeMyChannelView * viewA = (LeMyChannelView *)[[NSBundle mainBundle] loadNibNamed:@"LeMyChannelView" owner:self options:nil][0];
//    viewA.title = @"page A";
//    viewA.translatesAutoresizingMaskIntoConstraints=NO;
//    [self.segment1View addSubview:viewA];
    
    
    LeTestMusicView * viewA = (LeTestMusicView *)[[NSBundle mainBundle] loadNibNamed:@"LeTestMusicView" owner:self options:nil][0];
    viewA.translatesAutoresizingMaskIntoConstraints=NO;
    [self.segment1View addSubview:viewA];

    [viewA loadData];
    
    NSArray* hViewAConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[viewA]|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(viewA)];
    [NSLayoutConstraint activateConstraints:hViewAConstraintArray];
    
    NSArray* vViewAConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[viewA]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(viewA)];
    [NSLayoutConstraint activateConstraints:vViewAConstraintArray];


    
    
    LeMyChannelView * viewB = (LeMyChannelView *)[[NSBundle mainBundle] loadNibNamed:@"LeMyChannelView" owner:self options:nil][0];
    viewB.title = @"page B";
    viewB.translatesAutoresizingMaskIntoConstraints=NO;
    [self.segment2View addSubview:viewB];
    
    NSArray* hViewBConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[viewB]|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(@"viewB", viewB)];
    [NSLayoutConstraint activateConstraints:hViewBConstraintArray];
    
    NSArray* vViewBConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[viewB]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(@"viewB", viewB)];
    [NSLayoutConstraint activateConstraints:vViewBConstraintArray];

    
    
    
    LeMyChannelView * viewC = (LeMyChannelView *)[[NSBundle mainBundle] loadNibNamed:@"LeMyChannelView" owner:self options:nil][0];
    viewC.title = @"page C";
    viewC.translatesAutoresizingMaskIntoConstraints=NO;
    [self.segment3View addSubview:viewC];
    
    NSArray* hViewCConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[viewC]|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:NSDictionaryOfVariableBindings(viewC)];
    [NSLayoutConstraint activateConstraints:hViewCConstraintArray];
    
    NSArray* vViewCConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[viewC]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(viewC)];
    [NSLayoutConstraint activateConstraints:vViewCConstraintArray];
    

}


//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    //    self.scrollView.frame = [UIScreen mainScreen].bounds;
//    //    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//    //
//    __block CGFloat offsetValue = 0.0;
//    __block CGSize contentSize = CGSizeZero;
//    
//    if (self.scrollView.scrollDirection == DZNScrollDirectionHorizontal) {
//        [self.segmentedControl.items enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
//            CGRect frame = [UIScreen mainScreen].bounds;
//            frame.origin.x = offsetValue;
//            
//            [self addLabel:idx withFrame:frame];
//            
//            offsetValue += CGRectGetWidth(frame);
//        }];
//        
//        contentSize = CGSizeMake(offsetValue, self.scrollView.frame.size.height);
//    }
//    else {
//        [self.segmentedControl.items enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
//            CGRect frame = [UIScreen mainScreen].bounds;
//            frame.origin.y = offsetValue;
//            
//            [self addLabel:idx withFrame:frame];
//            
//            offsetValue += CGRectGetHeight(frame);
//        }];
//        
//        contentSize = CGSizeMake(self.scrollView.frame.size.width, offsetValue);
//    }
//    
//    self.scrollView.contentSize = contentSize;
//}

- (void)addLabel:(NSInteger)idx withFrame:(CGRect)frame
{
    
    LeMyChannelView * view = (LeMyChannelView *)[[NSBundle mainBundle] loadNibNamed:@"LeMyChannelView" owner:self options:nil][0];
    view.title = self.segmentedControl.items[idx];
    view.frame = frame;
    [self.scrollView addSubview:view];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:frame];
//    label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//    label.backgroundColor = (idx%2 == 0) ? [UIColor redColor] : [UIColor blueColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont systemFontOfSize:40];
//    label.text = self.segmentedControl.items[idx];
//    
//    [self.scrollView addSubview:label];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
        return;
    }
    
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    CGFloat width = scrollView.bounds.size.width;
    NSUInteger index = lroundf(x / width);
    [self.segmentedControl setSelectedSegmentIndex:index animated:TRUE];
}


#pragma mark - Events

- (IBAction)didChangeSegment:(id)sender
{
    NSLog(@"%s",__FUNCTION__);
}


#pragma mark - DZNSegmentedControlDelegate Methods

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionTop;
}

- (UIBarPosition)positionForSelectionIndicator:(id<UIBarPositioning>)bar
{
    return UIBarPositionBottom;
}


#pragma mark - View Auto-Rotation

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}


#pragma mark - View lifeterm

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    
}

@end