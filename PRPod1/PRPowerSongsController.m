//
//  PRPowerSongsController.m
//  PRPod1
//
//  Created by Adam Roth on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PRPowerSongsController.h"
#import "PRAppDelegate.h"

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
    static NSString *CellIdentifier = @"songCell";
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button addTarget:self action:@selector(aMethod:)
//     forControlEvents:UIControlEventTouchDown];
//    [button setTitle:@"Show View" forState:UIControlStateNormal];
//    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
//    //[cell addSubview:button];
//    //  [cell.detailTextLabel addSubview:button];
//    // Configure the cell.
//    
//    cell.songLabel.text = [NSString stringWithFormat:@"%@ - %@", [[self.results objectAtIndex:indexPath.row] valueForProperty: MPMediaItemPropertyArtist], [[self.results objectAtIndex:indexPath.row] valueForProperty: MPMediaItemPropertyTitle] ]; 
//    cell.detailTextLabel.text = @"TEST";
//    
//    cell.playButton.tag = indexPath.row;
//    cell.addButton.tag = indexPath.row;
//    cell.playButton.titleLabel.text = @">";
//    
//    [cell.playButton addTarget:self action:@selector(clicky:) forControlEvents:UIControlEventTouchDown];
//    [cell.addButton  addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchDown];
//    
    //    [[[cell subviews] objectAtIndex:0] setTitle:@"XX"];
    
    NSString *powerSongString = [[NSString alloc]initWithFormat:@"%@ - %@",[[delegate.powerSongs objectAtIndex:indexPath.row] objectForKey:@"artist"], [[delegate.powerSongs objectAtIndex:indexPath.row] objectForKey:@"title"]];
    cell.textLabel.text = powerSongString;
    
    return cell;
    
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

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


@end
