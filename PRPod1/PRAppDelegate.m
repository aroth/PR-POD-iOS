//
//  PRAppDelegate.m
//  PRPod1
//
//  Created by Adam Roth on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PRAppDelegate.h"

@implementation PRAppDelegate

@synthesize window = _window;
@synthesize powerSongs, powerHooks, player, timer, currentTrack, powerPodController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    self.powerSongs = [[NSMutableArray alloc]init];
    self.powerHooks = [[NSMutableArray alloc]init];
    
    self.player = [MPMusicPlayerController iPodMusicPlayer];
    
    if( [defaults objectForKey:@"powerSongs"] == nil ){
        [defaults setObject:[[NSArray alloc]init] forKey:@"powerSongs"];
    }
    
    if( [defaults objectForKey:@"powerHooks"] == nil ){
        [defaults setObject:[[NSArray alloc]init] forKey:@"powerHooks"];
    }
    
    // Settings
    if( [defaults objectForKey:@"settings_playContinuous"] == nil ){
        NSLog(@"DEF1");
        [defaults setBool:NO forKey:@"settings_playContinuous"];
    }
    if( [defaults objectForKey:@"settings_playSongs"] == nil ){
        NSLog(@"DEF2");
        [defaults setBool:YES forKey:@"settings_playSongs"];
    }
    if( [defaults objectForKey:@"settings_playHooks"] == nil ){
        NSLog(@"DEF3");
        [defaults setBool:NO forKey:@"settings_playHooks"];
    }

    [defaults synchronize];

    self.powerSongs = [[NSMutableArray alloc]initWithArray:[defaults arrayForKey:@"powerSongs"]];
    self.powerHooks = [[NSMutableArray alloc]initWithArray:[defaults arrayForKey:@"powerHooks"]];
    
    [self.player stop];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
     [[NSUserDefaults standardUserDefaults] synchronize];
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


- (void) playSong:(NSDictionary *)song onComplete:(void (^)(void))block { 
    
    MPMediaQuery *query = [MPMediaQuery songsQuery];   
    
    [self.timer invalidate];
    [self setCurrentTrack:song];
    
    
    [query addFilterPredicate:[MPMediaPropertyPredicate predicateWithValue:[song objectForKey:@"persistentID"] forProperty:MPMediaItemPropertyPersistentID comparisonType:MPMediaPredicateComparisonEqualTo]];
    [query setGroupingType:MPMediaGroupingTitle];
 
    [self.player setQueueWithItemCollection:[[MPMediaItemCollection alloc] initWithItems:[NSArray arrayWithObject:[query.items objectAtIndex:0]]]];
    
    if( [song objectForKey:@"start"] != nil ){
        // HOOK
        [self.player setCurrentPlaybackTime:[[song objectForKey:@"start"] floatValue]];
                
        SEL sel = @selector(processHook:);
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:sel]];
        [invocation setTarget:self];
        [invocation setSelector:sel];
        [invocation setArgument:&block atIndex:2];
        
        NSLog(@"BLOCK = =%@", block);
        
      //  [invocation performSelector:@selector(processHook:) withObject:block afterDelay:0.5];
        //        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5f invocation:invocation repeats:YES];

//        self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.5
//                                                 target: self
//                                                    invocation: invocation
//                                               userInfo: block
//                                                repeats: YES];
    }else{
        // SONG
        [self.player setCurrentPlaybackTime:0.0];
    }
    
    
    [self.player play];
    
}



- (void) processHook:(void (^)(void))block {
    if( [self.currentTrack objectForKey:@"stop"] != nil ){
        NSLog(@"FOUND HOOK %f vs %f", [self.player currentPlaybackTime], [[self.currentTrack objectForKey:@"stop"] floatValue]);
        if( [self.player currentPlaybackTime] > [[self.currentTrack objectForKey:@"stop"] floatValue] ){
            [self.timer invalidate];
            [self.player stop];

            if( block != nil ){
                block();
            }
            
            if( self.powerPodController != nil ){
                [self.powerPodController trackDone];
            }
            
            // }
            NSLog(@"HOOK DONE!!");
        }
    }
}

@end
