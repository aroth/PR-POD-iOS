//
//  PRSettingsController.h
//  PRPod1
//
//  Created by Adam Roth on 1/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRSettingsController : UIViewController {
    IBOutlet UISwitch *playContinuousSwitch;
    IBOutlet UISwitch *playSongsSwitch;
    IBOutlet UISwitch *playHooksSwitch;
}

@property (strong, nonatomic) IBOutlet UISwitch *playContinuousSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *playSongsSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *playHooksSwitch;

- (IBAction)toggleSetting:(id)sender;

@end
