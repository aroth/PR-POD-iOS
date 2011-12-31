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
}

@property (strong, nonatomic) IBOutlet UIButton *powerButton;
@property (strong, nonatomic) IBOutlet UILabel *songLabel;
@property (strong, nonatomic) IBOutlet UILabel *block;

@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (strong, nonatomic) IBOutlet UIImageView *bgRight;
@property (strong, nonatomic) IBOutlet UIImageView *bgLeft;
@property (strong, nonatomic) IBOutlet UIView *buttonView;

@property int songIndex;
@property int lastIndex;

- (IBAction)touchPowerButton:(id)sender;
- (void)playTrack;
- (void)playTimer;
- ( CATransform3D) compute_transform_matrix:(float)X
                                     Y:(float)Y
                                     W:(float)W
                                     H:(float)H 
                                   x1a:(float)x1a
                                   y1a:(float)y1a 
                                   x2a:(float)x2a 
                                   y2a:(float)y2a 
                                   x3a:(float)x3a 
                                   y3a:(float)y3a 
                                   x4a:(float)x4a 
                                   y4a:(float)y4a ;
@end
