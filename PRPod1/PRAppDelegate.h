//
//  PRAppDelegate.h
//  PRPod1
//
//  Created by Adam Roth on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer/MPMusicPlayerController.h"
#import "PRPowerPodController.h"

@interface PRAppDelegate : UIResponder <UIApplicationDelegate> {
    NSTimer *timer;
    NSDictionary *currentTrack;
    NSMutableArray *powerSongs;
    NSMutableArray *powerHooks;
    MPMusicPlayerController *player;
    PRPowerPodController *powerPodController;
}

@property (strong, nonatomic) PRPowerPodController *powerPodController;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSDictionary *currentTrack;
@property (nonatomic, strong) MPMusicPlayerController *player;
@property (nonatomic, strong) NSMutableArray *powerSongs;
@property (nonatomic, strong) NSMutableArray *powerHooks;

- (void) playSong:(NSDictionary *)song onComplete:(void (^)(void))block;
- (void) processHook:(void (^)(void))block;

@end
