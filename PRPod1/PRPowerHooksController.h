//
//  PRPowerHooksController.h
//  PRPod1
//
//  Created by Adam Roth on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRPowerHooksController : UIViewController <UITabBarDelegate, UITableViewDataSource> {
    IBOutlet UITableView *tableView;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
