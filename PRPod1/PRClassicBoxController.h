//
//  PRClassicBoxController.h
//  PRPod1
//
//  Created by Adam Roth on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PRClassicBoxController : UIViewController {
    
    IBOutlet UIButton *powerButtonLeftBottom;
}
@property (strong, nonatomic) IBOutlet UIButton *powerButtonLeftBottom;
- (IBAction)tapPowerButtonLeftBottom:(id)sender;

@end
