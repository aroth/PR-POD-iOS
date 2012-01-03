//
//  PRAppDelegate.h
//  PRPod1
//
//  Created by Adam Roth on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer/MPMusicPlayerController.h"

@interface PRAppDelegate : UIResponder <UIApplicationDelegate> {
    NSTimer *timer;
    NSDictionary *currentTrack;
    NSMutableArray *powerSongs;
    NSMutableArray *powerHooks;
    MPMusicPlayerController *player;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSDictionary *currentTrack;
@property (nonatomic, strong) MPMusicPlayerController *player;
@property (nonatomic, strong) NSMutableArray *powerSongs;
@property (nonatomic, strong) NSMutableArray *powerHooks;

- (void) playSong:(NSDictionary *)song;

@end
