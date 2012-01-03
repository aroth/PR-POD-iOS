//
//  PRHookEditorController.h
//  PRPod1
//
//  Created by Adam Roth on 12/31/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer/MPMusicPlayerController.h"

@interface PRHookEditorController : UIViewController {

    IBOutlet UILabel *artistLabel;
    IBOutlet UILabel *titleLabel;
    MPMediaItem *song;
    
    IBOutlet UIButton *playButton;
    IBOutlet UIButton *setStartButton;
    IBOutlet UIButton *setEndButton;
    IBOutlet UITextField *startTimeText;
    IBOutlet UITextField *endTimeText;
    IBOutlet UIButton *playHookButton;
    IBOutlet UIButton *saveHookButton;
}

@property (strong, nonatomic) IBOutlet UILabel *artistLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) MPMediaItem *song;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *setStartButton;
@property (strong, nonatomic) IBOutlet UIButton *setEndButton;
@property (strong, nonatomic) IBOutlet UITextField *startTimeText;
@property (strong, nonatomic) IBOutlet UITextField *endTimeText;
@property (strong, nonatomic) IBOutlet UIButton *playHookButton;
@property (strong, nonatomic) IBOutlet UIButton *saveHookButton;


@property (nonatomic, weak) id delegate;

- (IBAction)tapPlay:(id)sender;
- (IBAction)tapSetStart:(id)sender;
- (IBAction)tapSetEnd:(id)sender;
- (IBAction)tapPlayHook:(id)sender;
- (IBAction)tapSaveHook:(id)sender;

@end
