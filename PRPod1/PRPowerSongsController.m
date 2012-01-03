//
//  PRPowerSongsController.m
//  PRPod1
//
//  Created by Adam Roth on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PRPowerSongsController.h"
#import "PRAppDelegate.h"
#import "PRHookEditorController.h"
#import "PowersongCell.h"

@implementation PRPowerSongsController
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

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
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
    return [delegate.powerSongs count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];

    PowersongCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:@"PowersongCell"];
    
    NSString *powerSongString = [[NSString alloc]initWithFormat:@"%@ - %@",[[delegate.powerSongs objectAtIndex:indexPath.row] objectForKey:@"artist"], [[delegate.powerSongs objectAtIndex:indexPath.row] objectForKey:@"title"]];
    cell.songLabel.text = powerSongString;
  //  cell.song = [delegate.powerSongs objectAtIndex:indexPath.row];
    
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
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [delegate.powerSongs removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];

        // Update persistent list in user settings
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:@"XXX" forKey:@"adam_test"]; 
        [defaults setObject:[delegate powerSongs] forKey:@"powerSongs"];
        NSLog(@"[delete add PS == %@", [defaults objectForKey:@"powerSongs"]);
        
        [defaults synchronize];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // TODO: 
        // IF SONG IS PLAYING, STOP IT
    }    
}

#pragma mark - Segue methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    if( [[segue identifier] isEqualToString:@"EditHookSegue"] ){
        PRHookEditorController *vc = segue.destinationViewController;
        NSDictionary *song = [delegate.powerSongs objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
            
        MPMediaQuery *query = [MPMediaQuery songsQuery];   
        [query addFilterPredicate:[MPMediaPropertyPredicate predicateWithValue:[song objectForKey:@"persistentID"] forProperty:MPMediaItemPropertyPersistentID comparisonType:MPMediaPredicateComparisonEqualTo]];
        [query setGroupingType:MPMediaGroupingTitle];
            
     
        if( [query.items count] > 0 ){
            [vc setDelegate:self];
            [vc setSong:[query.items objectAtIndex:0]];
        }else{
            NSLog(@"COULD NOT FIND SONG IN LIBRARY FOR %@", song);
        }
            //    [vc setSong:
    }   
    
    
    
    //[vc setSong:[delegate.player nowPlayingItem]];
   // [segue.destinationViewController setSong:@"s"];
}



@end
