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
    IBOutlet UITextField *remoteIPTextField;
    IBOutlet UITextField *remoteStatus;
    IBOutlet UIButton *remoteButton;
}

@property (strong, nonatomic) IBOutlet UISwitch *playContinuousSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *playSongsSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *playHooksSwitch;
@property (strong, nonatomic) IBOutlet UITextField *remoteIPTextField;
@property (strong, nonatomic) IBOutlet UITextField *remoteStatus;
@property (strong, nonatomic) IBOutlet UIButton *remoteButton;

- (IBAction)toggleSetting:(id)sender;
- (IBAction)tapRemoteButton:(id)sender;
- (void)adjustConnectionStatus;

@end
