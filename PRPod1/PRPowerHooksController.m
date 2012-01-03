//
//  PRPowerHooksController.m
//  PRPod1
//
//  Created by Adam Roth on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PRPowerHooksController.h"
#import "PRAppDelegate.h"
#import "HookCell.h"


@implementation PRPowerHooksController
@synthesize tableView;

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

- (void) viewWillAppear:(BOOL)animated  {
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    tableView = nil;
    [self setTableView:nil];
    tableView = nil;
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - Table Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    return [delegate.powerHooks count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    HookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HookCell"];
    
    NSDictionary *hook = [delegate.powerHooks objectAtIndex:indexPath.row];
    
    cell.song = hook;
    cell.artistLabel.text = [hook objectForKey:@"artist"];
    cell.titleLabel.text  = [hook objectForKey:@"title"];
    cell.rangeLabel.text = [NSString stringWithFormat:@"%@ - %@", [hook objectForKey:@"start"], [hook objectForKey:@"stop"]];
    
    
    //NSString *powerHookString = [[NSString alloc]initWithFormat:@"%@ - %@",[[delegate.powerHooks objectAtIndex:indexPath.row] objectForKey:@"artist"], [[delegate.powerHooks objectAtIndex:indexPath.row] objectForKey:@"title"]];
    //cell.textLabel.text = powerHookString;
  //  cell.song
//    
    
    
    
    return cell;
    
}

// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
// Return YES if you want the specified item to be editable.
//   return NO;
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  DLAppDelegate *ad = [[UIApplication sharedApplication] delegate];
//   [ad.workout setValue:[[searchData objectAtIndex:indexPath.row] objectForKey:@"name"] forKey:@"where"];
//    [self.navigationController popViewControllerAnimated:YES];

//  NSLog(@"GOT HERE...?");
//}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [delegate.powerHooks removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        
        // Update persistent list in user settings
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:[delegate powerHooks] forKey:@"powerHooks"];
        
        [defaults setObject:@"XXX" forKey:@"adam_test"]; 
        [defaults synchronize];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // TODO: 
        // IF HOOK IS PLAYING, STOP IT
    }    
}


@end
