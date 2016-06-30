//
//  FISViewController.m
//  theFinalCountdown
//
//  Created by Joe Burgess on 7/9/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"

@interface FISViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailTimeLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSUInteger counterSeconds;


@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailTimeLabel.hidden = YES;
    self.cancelButton.hidden = YES;

}

- (void)viewWillAppear:(BOOL)animated
{


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startTapped:(id)sender {
    self.detailTimeLabel.hidden = NO;
    self.datePicker.hidden = YES;
    self.startButton.enabled = NO;
    self.startButton.hidden = YES;
    self.cancelButton.enabled = YES;
    self.cancelButton.hidden = NO;
    self.pauseButton.enabled = YES;
    
    // gets user input of time (in amount of seconds)
    NSUInteger selectedTimeInSeconds = (NSUInteger )self.datePicker.countDownDuration;
    
    self.counterSeconds = selectedTimeInSeconds;
    
    [self setTimeLabel];
    
    // making countdown
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeLabel) userInfo:nil repeats:YES];
}

- (IBAction)pauseTapped:(id)sender {
    //self.counterSeconds;
    if (self.timer == nil) {
        self.timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeLabel) userInfo:nil repeats:YES];
    } else {
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

- (IBAction)cancelTapped:(id)sender {
    [self.timer invalidate];
    self.detailTimeLabel.hidden = YES;
    self.datePicker.hidden = NO;
    self.startButton.enabled = YES;
    self.startButton.hidden = NO;
    self.cancelButton.enabled = NO;
    self.cancelButton.hidden = YES;
    self.pauseButton.enabled = NO;
}

-(void)updateTimeLabel{
    [self setTimeLabel];
    self.counterSeconds -= 1;
    if (self.counterSeconds == 0) {
        [self.timer invalidate];
        self.detailTimeLabel.text = @"00 : 00 : 00";
    }
}

- (void)setTimeLabel {
    NSUInteger hours = self.counterSeconds / 3600;
    NSUInteger minuts = self.counterSeconds / 60 - hours * 60;
    NSUInteger seconds = self.counterSeconds - hours * 3600 - minuts * 60;
    
    if (minuts < 10 && seconds < 10) {
        self.detailTimeLabel.text = [NSString stringWithFormat:@"%lu : 0%lu : 0%lu", hours, minuts,seconds];
    } else if (minuts < 10) {
        self.detailTimeLabel.text = [NSString stringWithFormat:@"%lu : 0%lu : %lu", hours, minuts,seconds];
    } else if (seconds < 10) {
        self.detailTimeLabel.text = [NSString stringWithFormat:@"%lu : %lu : 0%lu", hours, minuts,seconds];
    } else {
        self.detailTimeLabel.text = [NSString stringWithFormat:@"%lu : %lu : %lu", hours, minuts, seconds];
    }
}

@end
