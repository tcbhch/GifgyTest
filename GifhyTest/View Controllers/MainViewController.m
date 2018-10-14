//
//  MainViewController.m
//  GifhyTest
//
//  Created by Adi Bonder on 10/11/18.
//  Copyright © 2018 Adi Bonder. All rights reserved.
//

#import "MainViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "GifsViewController.h"

@interface MainViewController () {
    AVAudioPlayer *player;
}

@end

@implementation MainViewController
@synthesize playPauseButton;
@synthesize searchGifsButton;
@synthesize trendingButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    playPauseButton.layer.borderWidth = 0.5f;
    playPauseButton.layer.borderColor = [UIColor whiteColor].CGColor;
    playPauseButton.layer.cornerRadius = 5.0f;
    searchGifsButton.layer.borderWidth = 0.5f;
    searchGifsButton.layer.borderColor = [UIColor whiteColor].CGColor;
    searchGifsButton.layer.cornerRadius = 5.0f;
    trendingButton.layer.borderWidth = 0.5f;
    trendingButton.layer.borderColor = [UIColor whiteColor].CGColor;
    trendingButton.layer.cornerRadius = 5.0f;
    [self playMusic];
}

- (IBAction)searchButtonPressed:(UIButton *)sender {
    [self moveToGifsPageWithSearchOption:NO];
}

- (IBAction)trendingButtonPressed:(UIButton *)sender {
    [self moveToGifsPageWithSearchOption:YES];
}

- (IBAction)playPauseButtonPressed:(UIButton *)sender {
    if ([player isPlaying]) {
        [player pause];
        [playPauseButton setTitle:@"Back to happiness :)" forState:UIControlStateNormal];
    } else {
        [player play];
        [playPauseButton setTitle:@"I want to worry and be unhappy :(" forState:UIControlStateNormal];
    }
}

-(void)moveToGifsPageWithSearchOption:(BOOL)shouldHideSearchBar {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GifsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"gifsvc"];
    vc.shouldHideSearchBar = shouldHideSearchBar;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)playMusic
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Dont Worry Be Happy" ofType:@"mp3"];
    NSError *error = nil;
    NSURL *url = [NSURL fileURLWithPath:path];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [player play];
}

@end
