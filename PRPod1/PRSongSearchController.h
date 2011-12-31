//
//  PRSongSearchController.h
//  PRPod1
//
//  Created by Adam Roth on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRSongSearchController : UIViewController  <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {
    IBOutlet UISearchBar *searchBar;
    IBOutlet UITableView *tableView;
    NSArray *results;
}
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSArray *results;

@end
