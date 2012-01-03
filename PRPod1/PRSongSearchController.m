//
//  PRSongSearchController.m
//  PRPod1
//
//  Created by Adam Roth on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PRSongSearchController.h"
#import "PRAppDelegate.h"
#import "SongCell.h"

@implementation PRSongSearchController
@synthesize tableView;
@synthesize searchBar, results;

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

- (void)viewDidUnload
{
    searchBar = nil;
    [self setSearchBar:nil];
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
    return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SongCell";
    
    SongCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SongCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.songLabel.text = [NSString stringWithFormat:@"%@ - %@", [[self.results objectAtIndex:indexPath.row] valueForProperty: MPMediaItemPropertyArtist], [[self.results objectAtIndex:indexPath.row] valueForProperty: MPMediaItemPropertyTitle] ]; 
    cell.playButton.tag = indexPath.row;
    cell.addButton.tag = indexPath.row;

    // events
    [cell.playButton addTarget:self action:@selector(playSong:) forControlEvents:UIControlEventTouchDown];
    [cell.addButton  addTarget:self action:@selector(addSong:) forControlEvents:UIControlEventTouchDown];

    return cell;
    
}

- (void) playSong:(id)sender {
    UIButton *from = (UIButton *)sender;
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    MPMediaItem *item = [self.results objectAtIndex:from.tag];
    NSArray *items = [[NSArray alloc]initWithObjects:item,nil];
    MPMediaItemCollection *col = [[MPMediaItemCollection alloc]initWithItems:items];
    
    [delegate.player setQueueWithItemCollection:col];
    [delegate.player play];
}

- (void) addSong:(id)sender {
    UIButton *from = (UIButton *)sender;
    
    PRAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    MPMediaItem *item = [self.results objectAtIndex:from.tag];

    NSMutableDictionary *powerSong = [[NSMutableDictionary alloc]init];
    [powerSong setObject:[item valueForProperty:MPMediaItemPropertyPersistentID] forKey:@"persistentID"];
    [powerSong setObject:[item valueForProperty:MPMediaItemPropertyArtist] forKey:@"artist"];
    [powerSong setObject:[item valueForProperty:MPMediaItemPropertyTitle] forKey:@"title"];
    
    
    [delegate.powerSongs addObject:powerSong];  
    
    [delegate.powerSongs sortUsingComparator: ^(id obj1, id obj2){
        NSDictionary *ps1 = (NSDictionary *)obj1;
        NSDictionary *ps2 = (NSDictionary *)obj2;
        return [[ps1 objectForKey:@"artist"] compare:[ps2 objectForKey:@"artist"]];
    }];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"XXX" forKey:@"adam_test"]; 
    [defaults setObject:[delegate powerSongs] forKey:@"powerSongs"];
    NSLog(@"[search add PS == %@", [defaults objectForKey:@"powerSongs"]);

    [defaults synchronize];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


# pragma mark - Search Bar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar {
    MPMediaQuery *query = [MPMediaQuery songsQuery];   
    [query addFilterPredicate:[MPMediaPropertyPredicate predicateWithValue:self.searchBar.text forProperty:MPMediaItemPropertyTitle comparisonType:MPMediaPredicateComparisonContains]];
    [query setGroupingType:MPMediaGroupingTitle];
    self.results = query.items;
    
    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
}

@end
