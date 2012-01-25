//
//  PRClassicBoxController.m
//  PRPod1
//
//  Created by Adam Roth on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PRClassicBoxController.h"
#import "PRAppDelegate.h"

@implementation PRClassicBoxController
@synthesize powerButtonLeftBottom;
@synthesize timeLabel;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    

}

- (void)viewDidUnload
{
    powerButtonLeftBottom = nil;
    [self setPowerButtonLeftBottom:nil];
    timeLabel = nil;
    [self setTimeLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)button2:(id)sender {
}

- (IBAction)tapPowerButtonLeftBottom:(id)sender {
 //   [self dismissModalViewControllerAnimated:YES];

    
   // NSString *str = @"hello";
   // NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
  //  [asyncSocket writeData:data withTimeout:4.0 tag:1];
   // [asyncSocket readDataToLength:20.0 withTimeout:-1 tag:-1];
 //   [asyncSocket readDataToLength:20.0 withTimeout:-1 tag:-1];
//    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
[self dismissModalViewControllerAnimated:YES];
}

- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"Cool, I'm connected! That was easy.");
}

- (void)socket:(GCDAsyncSocket *)sender didReadData:(NSData *)data withTag:(long)tag
{
        PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSString *content = [[NSString alloc] initWithData:data
                                               encoding:NSUTF8StringEncoding];                     
    if( [data length] > 5 ){
      //  self.timeLabel.text = content;
         
        NSLog(@"GOT HERE WITH %@ and %@", data, content);
    }
    [delegate.asyncSocket readDataWithTimeout:-1 tag:0];

}

@end
