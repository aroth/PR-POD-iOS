//
//  PRFirstViewController.m
//  PRPod1
//
//  Created by Adam Roth on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PRPowerPodController.h"
#import "PRAppDelegate.h"
#import <QuartzCore/QuartzCore.h>


@implementation PRPowerPodController
@synthesize powerButton;
@synthesize bgImage;
@synthesize bgRight;
@synthesize bgLeft;
@synthesize buttonView;
@synthesize grec;

@synthesize songLabel;
@synthesize block;
@synthesize songLED;
@synthesize hookLED;
@synthesize songIndex, lastIndex;
@synthesize audioPlayer;

#define CATransform3DPerspective(t, x, y) (CATransform3DConcat(t, CATransform3DMake(1, 0, 0, x, 0, 1, 0, y, 0, 0, 1, 0, 0, 0, 0, 1)))
#define CATransform3DMakePerspective(x, y) (CATransform3DPerspective(CATransform3DIdentity, x, y))

CG_INLINE CATransform3D
CATransform3DMake(CGFloat m11, CGFloat m12, CGFloat m13, CGFloat m14,
				  CGFloat m21, CGFloat m22, CGFloat m23, CGFloat m24,
				  CGFloat m31, CGFloat m32, CGFloat m33, CGFloat m34,
				  CGFloat m41, CGFloat m42, CGFloat m43, CGFloat m44)
{
	CATransform3D t;
	t.m11 = m11; t.m12 = m12; t.m13 = m13; t.m14 = m14;
	t.m21 = m21; t.m22 = m22; t.m23 = m23; t.m24 = m24;
	t.m31 = m31; t.m32 = m32; t.m33 = m33; t.m34 = m34;
	t.m41 = m41; t.m42 = m42; t.m43 = m43; t.m44 = m44;
	return t;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.songLabel.text = @"PR Pod";
    self.songIndex = -1; // not playing
    [self.songLabel setFont:[UIFont fontWithName:@"DS-Digital-Bold" size:30.0]];
    // powerPodController
    
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate setPowerPodController:self];
    
}

- (void)viewDidUnload
{
    powerButton = nil;
    [self setPowerButton:nil];
    songLabel = nil;
    [self setSongLabel:nil];
    bgImage = nil;
    bgRight = nil;
    [self setBgRight:nil];
    [self setBgImage:nil];
    [self setBgLeft:nil];
    block = nil;
    [self setBlock:nil];
    buttonView = nil;
    [self setButtonView:nil];
    grec = nil;
    [self setGrec:nil];
    songLED = nil;
    [self setSongLED:nil];
    hookLED = nil;
    [self setHookLED:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    // restart scroll
    [self scrollText:self.songLabel.text];
    [self.powerButton addGestureRecognizer:grec];
    

    [super viewWillAppear:animated];
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate sendRemoteData:@"CONGRATS ON PR|IM PROUD OF YOU"];
    [self playTrack];
}

- (IBAction)grec_event:(UILongPressGestureRecognizer *)gesture {
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if( gesture.state == UIGestureRecognizerStateBegan){
        [self prAction];
        
    }else if( gesture.state == UIGestureRecognizerStateEnded ){
        NSLog(@"ENDED");
    }
}


- (void)prAction {
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];

    [self scrollText:@"PERSONAL RECORD!!"];
    [delegate sendRemoteData:@"POWER"];
    
    NSURL *url = [[NSURL alloc]initFileURLWithPath:[NSString stringWithFormat:@"%@/sun_power.wav", [[NSBundle mainBundle] resourcePath]]];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = 2;
    audioPlayer.delegate = self;
    
    NSLog(@"PLAY THE SONG at %@!", [NSString stringWithFormat:@"%@/cutler_champions.wav", [[NSBundle mainBundle] resourcePath]]);
    
    if (audioPlayer == nil)
        NSLog([error description]);
    else
        [audioPlayer prepareToPlay];
        [audioPlayer play];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)touchPowerButton:(id)sender {
    
    if( self.songIndex == -1 ){
        [self playTrack];
    }else{
        [self trackDone];
    }
}



- (void)trackDone {
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // TODO //
    if( [defaults boolForKey:@"settings_playContinuous"] == YES ){
        [self playTrack];
    }else{

        self.songLED.image = [UIImage imageNamed:@"song_off"];
        self.hookLED.image = [UIImage imageNamed:@"hook_off"];

        
        self.songIndex = -1;
        [delegate.player stop];
        [delegate.timer invalidate];    
        [self scrollText:@""];        
    }
    
}

- (void)playTrack {
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    
    NSArray *toUse;
    
    if( [defaults boolForKey:@"settings_playSongs"] == YES && 
        [defaults boolForKey:@"settings_playHooks"] == YES ){
        toUse = [delegate.powerSongs arrayByAddingObjectsFromArray:delegate.powerHooks];

    }else if( [defaults boolForKey:@"settings_playSongs"] == YES ){
        toUse = [NSArray arrayWithArray:delegate.powerSongs];

    }else if( [defaults boolForKey:@"settings_playHooks"] == YES ){
        toUse = [NSArray arrayWithArray:delegate.powerHooks];
        
    }else{
        // NEITHER SELECTED //
        [self trackDone];
        [self scrollText:@"Neither SONGS nor HOOKS selected"];
        return;
    }
             
    
    if( [toUse count] == 0 ){
        [self scrollText:@"No tracks available."];
        [delegate sendRemoteData:@"NO TRACKS|AVAILABLE"];
        return;
    }
    
    self.songIndex = arc4random() % [toUse count];

//    [[toUse objectAtIndex:self.songIndex] setObject:@"80.0" forKey:@"stop"];
    // HOOK // TODO: Make this return BOOL

    NSDictionary *selectedSong = [toUse objectAtIndex:self.songIndex];
    
    if( [selectedSong objectForKey:@"start"] != nil ){
        // HOOK
        self.songLED.image = [UIImage imageNamed:@"song_off"];
        self.hookLED.image = [UIImage imageNamed:@"hook_on"];

    }else{
        // SONG
        self.songLED.image = [UIImage imageNamed:@"song_on"];
        self.hookLED.image = [UIImage imageNamed:@"hook_off"];
        
    }
    
    [delegate playSong:selectedSong onComplete:^{
        NSLog(@"IN ONCOMPLETE CALLBACK with SELF ==");
    
    }];  
    
    
    // SONG
    
    NSString *powerSongString = [[NSString alloc]initWithFormat:@"%@ - %@",[[toUse objectAtIndex:self.songIndex] objectForKey:@"artist"], [[toUse objectAtIndex:self.songIndex] objectForKey:@"title"]];
    [self scrollText:powerSongString];
    

    // TODO: Handle errors, scroll "ERROR"...
    
}

- (void)scrollText:(NSString *)text {
    
    self.songLabel.text = text;
    CGSize expectedLabelSize = [self.songLabel.text sizeWithFont:self.songLabel.font 
                                               constrainedToSize:CGSizeMake(700, 43)
                                                   lineBreakMode:self.songLabel.lineBreakMode]; 
    
    CGRect newFrame = self.songLabel.frame;
    newFrame.size.width = expectedLabelSize.width;
    newFrame.origin = CGPointMake(300, 51); // reset
    
    self.songLabel.layer.frame = newFrame;


    CABasicAnimation *scrollText;
    scrollText=[CABasicAnimation animationWithKeyPath:@"position.x"];
    scrollText.duration = 6.5;
    scrollText.repeatCount = 10000;
    scrollText.autoreverses = NO;
    //scrollText.fromValue = [NSNumber numberWithFloat:293.0 + (293.0 * 0.5)];          // fromValue = origin
    scrollText.toValue = [NSNumber numberWithFloat: (expectedLabelSize.width + 10) * -1];
    
    [[self.songLabel layer] removeAllAnimations];
    [[self.songLabel layer] addAnimation:scrollText forKey:@"scrollTextKey"];
}

- (void)playTimer {

    
    
}

- (IBAction)dispenseChalk:(id)sender {
    NSLog(@"CHALK!!");
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate sendRemoteData:@"CHALK"];
}

- (IBAction)ringBell:(id)sender {
    NSLog(@"BELL!!");
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate sendRemoteData:@"BELL"];
}


- (IBAction)changeTheme:(id)sender {
    // THEME // ---------------------
    [bgImage setImage:[UIImage imageNamed:@"diamond_plate"]];
    [bgLeft  setImage:[UIImage imageNamed:@"s_left.png"]];
    [bgRight setImage:[UIImage imageNamed:@"s_right.png"]];        
    
}
- (IBAction)changeTheme2:(id)sender {
    // THEME // ---------------------
    [bgImage setImage:[UIImage imageNamed:@"prbox.png"]];
    [bgLeft  setImage:[UIImage imageNamed:@"blk_left.png"]];
    [bgRight setImage:[UIImage imageNamed:@"blk_right.png"]];

    NSLog(@"????");
}

@end
