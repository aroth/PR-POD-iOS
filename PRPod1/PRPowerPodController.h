//
//  PRFirstViewController.h
//  PRPod1
//
//  Created by Adam Roth on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PRPowerPodController : UIViewController {
    IBOutlet UIButton *powerButton;
    IBOutlet UILabel *songLabel;

    IBOutlet UIImageView *bgImage;
    IBOutlet UIImageView *bgLeft;
    IBOutlet UIImageView *bgRight;
    
    IBOutlet UIView *buttonView;
    IBOutlet UILabel *block;
    int songIndex;
    int lastIndex;
    IBOutlet UILongPressGestureRecognizer *grec;
}

@property (strong, nonatomic) IBOutlet UIButton *powerButton;
@property (strong, nonatomic) IBOutlet UILabel *songLabel;
@property (strong, nonatomic) IBOutlet UILabel *block;

@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (strong, nonatomic) IBOutlet UIImageView *bgRight;
@property (strong, nonatomic) IBOutlet UIImageView *bgLeft;
@property (strong, nonatomic) IBOutlet UIView *buttonView;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *grec;

@property int songIndex;
@property int lastIndex;

- (IBAction)touchPowerButton:(id)sender;
- (void)playTrack;
- (void)playTimer;
- (void)scrollText:(NSString *)text;

@end
