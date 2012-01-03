//
//  PRHookEditorController.m
//  PRPod1
//
//  Created by Adam Roth on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PRHookEditorController.h"
#import "PRAppDelegate.h"

@implementation PRHookEditorController
@synthesize artistLabel;
@synthesize titleLabel;
@synthesize playButton;
@synthesize setStartButton;
@synthesize setEndButton;
@synthesize startTimeText;
@synthesize endTimeText;
@synthesize playHookButton;
@synthesize saveHookButton;
@synthesize song;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewWillAppear:(BOOL)animated {
    PRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    self.artistLabel.text = [self.song valueForProperty:MPMediaItemPropertyArtist];
    self.titleLabel.text  = [self.song valueForProperty:MPMediaItemPropertyTitle];
    
    [appDelegate.player stop];
}

- (void)viewDidUnload
{
    playButton = nil;
    [self setPlayButton:nil];
    setStartButton = nil;
    [self setSetStartButton:nil];
    setEndButton = nil;
    [self setSetEndButton:nil];
    startTimeText = nil;
    endTimeText = nil;
    [self setStartTimeText:nil];
    [self setEndTimeText:nil];
    playHookButton = nil;
    [self setPlayHookButton:nil];
    artistLabel = nil;
    titleLabel = nil;
    [self setTitleLabel:nil];
    [self setArtistLabel:nil];
    
    
    song = nil;
    [self setSong:nil];
    
    saveHookButton = nil;
    [self setSaveHookButton:nil];
    [super viewDidUnload];
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)tapPlay:(id)sender {
    PRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    [appDelegate.player setQueueWithItemCollection:[[MPMediaItemCollection alloc] initWithItems:[NSArray arrayWithObject:self.song]]];
    [appDelegate.player play];    
}
     
- (IBAction)tapSetStart:(id)sender {
    // ONLY if the song is playing
    PRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.startTimeText.text = [NSString stringWithFormat:@"%f",[appDelegate.player currentPlaybackTime]];
}

- (IBAction)tapSetEnd:(id)sender {
    // ONLY if song is playing
    PRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.endTimeText.text = [NSString stringWithFormat:@"%f",[appDelegate.player currentPlaybackTime]];
}

- (IBAction)tapPlayHook:(id)sender {
    // ONLY if hook is defined and song is playing
    PRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.player setCurrentPlaybackTime:[self.startTimeText.text floatValue]];  
}

- (IBAction)tapSaveHook:(id)sender {
    // save hook: need to have song, start, end
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    PRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary *hook = [[NSMutableDictionary alloc]init];
    
    [hook setObject:[self.song valueForProperty:MPMediaItemPropertyPersistentID] forKey:@"persistentID"];
    [hook setObject:[self.song valueForProperty:MPMediaItemPropertyTitle] forKey:@"title"];
    [hook setObject:[self.song valueForProperty:MPMediaItemPropertyArtist] forKey:@"artist"];
    [hook setObject:[NSNumber numberWithDouble:[self.startTimeText.text doubleValue]] forKey:@"start"];
    [hook setObject:[NSNumber numberWithDouble:[self.endTimeText.text doubleValue]] forKey:@"stop"];
    
    [appDelegate.powerHooks addObject:hook];
    [defaults setObject:appDelegate.powerHooks forKey:@"powerHooks"];
    [defaults synchronize];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"HOOKS = %@", appDelegate.powerHooks);
}

@end
