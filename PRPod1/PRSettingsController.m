//
//  PRSettingsController.m
//  PRPod1
//
//  Created by Adam Roth on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PRSettingsController.h"

@implementation PRSettingsController
@synthesize playContinuousSwitch;
@synthesize playSongsSwitch;
@synthesize playHooksSwitch;

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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if( [defaults boolForKey:@"settings_playContinuous"] == YES ){
        self.playContinuousSwitch.on = YES;
    }else{
        self.playContinuousSwitch.on = NO;
    }
    

    if( [defaults boolForKey:@"settings_playSongs"] == YES ){
        self.playSongsSwitch.on = YES;
    }else{
        self.playSongsSwitch.on = NO;
    }

    
    if( [defaults boolForKey:@"settings_playHooks"] == YES ){
        self.playHooksSwitch.on = YES;
    }else{
        self.playHooksSwitch.on = NO;
    }
}


- (IBAction)toggleSetting:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.playContinuousSwitch.on forKey:@"settings_playContinuous"];
    [defaults setBool:self.playSongsSwitch.on forKey:@"settings_playSongs"];
    [defaults setBool:self.playHooksSwitch.on forKey:@"settings_playHooks"];
    [defaults synchronize];

    
    [defaults setObject:@"XXX" forKey:@"adam_test"]; 
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"SAVED SETTINGS: %@", defaults);
}


- (void)viewDidUnload
{
    playContinuousSwitch = nil;
    [self setPlayContinuousSwitch:nil];
    playSongsSwitch = nil;
    [self setPlaySongsSwitch:nil];
    playHooksSwitch = nil;
    [self setPlayHooksSwitch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
