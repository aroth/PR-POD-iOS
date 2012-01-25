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
#import "PRSettingsController.h"
#import "GCDAsyncSocket.h"

@interface PRAppDelegate : UIResponder <UIApplicationDelegate> {
    NSTimer *timer;
    GCDAsyncSocket *asyncSocket;
    NSDictionary *currentTrack;
    NSMutableArray *powerSongs;
    NSMutableArray *powerHooks;
    MPMusicPlayerController *player;
    PRPowerPodController *powerPodController;
    PRSettingsController *settingsController;
}

@property (strong, nonatomic) GCDAsyncSocket *asyncSocket;
@property (strong, nonatomic) PRPowerPodController *powerPodController;
@property (strong, nonatomic) PRSettingsController *settingsController;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSDictionary *currentTrack;
@property (nonatomic, strong) MPMusicPlayerController *player;
@property (nonatomic, strong) NSMutableArray *powerSongs;
@property (nonatomic, strong) NSMutableArray *powerHooks;

- (void) playSong:(NSDictionary *)song onComplete:(void (^)(void))block;
- (void) processHook:(void (^)(void))block;
- (void) connectToRemote;
- (void) sendRemoteData:(NSString *)stringData;


@end
