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

@synthesize songLabel;
@synthesize block;
@synthesize songIndex, lastIndex;

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    CABasicAnimation *scrollText;
    // SKEW BLOCK 
    CATransform3D matrix;
    
    scrollText=[CABasicAnimation animationWithKeyPath:@"position.x"];
    scrollText.duration = 6.5;
    scrollText.repeatCount = 10000;
    scrollText.autoreverses = NO;
    scrollText.fromValue = [NSNumber numberWithFloat:500.0];
    scrollText.toValue = [NSNumber numberWithFloat:-250.0];
    
    
    [[self.songLabel layer] addAnimation:scrollText forKey:@"scrollTextKey"];
    
//    matrix = [self compute_transform_matrix:77.0 Y:112.0 W:166.0 H:71.0
//                                        x1a:77.0 y1a:112.0 
//                                        x2a:237.0 y2a:112.0 
//                                        x3a:77.0 y3a:183.0 
//                                        x4a:237.0 y4a:183.0];

    
//    matrix = [self compute_transform_matrix:77.0 Y:112.0 W:166.0 H:71.0
//                                        x1a:77.0 y1a:112.0 
//                                        x2a:77.0 y2a:183.0 
//                                        x3a:237.0 y3a:183.0 
//                                        x4a:237.0 y4a:112.0];

//    
//    matrix = [self compute_transform_matrix:0.0 Y:0.0 W:100.0 H:100.0
//                                        x1a:0.0 y1a:0.0 
//                                        x2a:0 y2a:100.0 
//                                        x3a:100.0 y3a:100.0 
//                                        x4a:100.0 y4a:0.0];


//    
//    float angle = -30.0/180*M_PI;
//    CATransform3D skew = CATransform3DIdentity;
//    skew.m24 = 0.001967;; tanf(-angle);
//    skew.m24 = tanf(angle);

    //self.songLabel.layer.transform = skew;
    
    
    //self.block.layer.transform = skew;

//    self.songLabel.layer.transform = CATransform3DMakePerspective(0,-0.005);

    //    CALayer *layer = self.block.layer;
//    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
//    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
//    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 85.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
//    layer.transform = rotationAndPerspectiveTransform;
//    
    
    

    [super viewWillAppear:animated];
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
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    if( self.songIndex == -1 ){
        [self playTrack];
    }else{
        self.songIndex = -1;
        self.songLabel.text = @"";
        [delegate.player stop];
    }
}

- (void)playTrack {
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    if( [delegate.powerSongs count] == 0 ){
        self.songLabel.text = @"NO POWER SONGS";
        return;
    }
    
    self.songIndex = arc4random() % [delegate.powerSongs count];
    
//    NSArray *items = [[NSArray alloc]initWithObjects:[delegate.powerSongs objectAtIndex:self.songIndex],nil];
//    MPMediaItemCollection *col = [[MPMediaItemCollection alloc]initWithItems:items];

    MPMediaQuery* query = [MPMediaQuery songsQuery];   
    [query addFilterPredicate:[MPMediaPropertyPredicate predicateWithValue:[[delegate.powerSongs objectAtIndex:self.songIndex] objectForKey:@"persistentID"] forProperty:MPMediaItemPropertyPersistentID comparisonType:MPMediaPredicateComparisonEqualTo]];
    [query setGroupingType:MPMediaGroupingTitle];
    [delegate.player setQueueWithQuery:query];

    if( [query.items count] > 0 ){
        [delegate.player play];
        NSString *powerSongString = [[NSString alloc]initWithFormat:@"%@ - %@",[[delegate.powerSongs objectAtIndex:self.songIndex] objectForKey:@"artist"], [[delegate.powerSongs objectAtIndex:self.songIndex] objectForKey:@"title"]];
        self.songLabel.text = powerSongString;
    
    }else{
        self.songLabel.text = @"ERROR";
    }
    
    CGSize expectedLabelSize = [self.songLabel.text sizeWithFont:self.songLabel.font 
                                               constrainedToSize:CGSizeMake(700, 43)
                                                   lineBreakMode:self.songLabel.lineBreakMode]; 
    
    CGRect newFrame = self.songLabel.frame;
    newFrame.size.width = expectedLabelSize.width;
    newFrame.origin = CGPointMake(293, 52); // reset
    
    self.songLabel.frame = newFrame;
    
        CABasicAnimation *scrollText;
    scrollText=[CABasicAnimation animationWithKeyPath:@"position.x"];
    scrollText.duration = 6.5;
    scrollText.repeatCount = 10000;
    scrollText.autoreverses = NO;
    scrollText.fromValue = [NSNumber numberWithFloat:500.0];
    scrollText.toValue = [NSNumber numberWithFloat:-250.0];
    
    [[self.songLabel layer] removeAllAnimations];
    [[self.songLabel layer] addAnimation:scrollText forKey:@"scrollTextKey"];
    
    
    NSLog(@"SIZE = %f,%f", expectedLabelSize.width, expectedLabelSize.height);
    
}

- (void)playTimer {
    
    
    
    
    
    
    
    
    
    
    
    
    
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
