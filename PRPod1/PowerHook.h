//
//  PowerHook.h
//  PRPod1
//
//  Created by Adam Roth on 1/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PowerHook : NSObject {
    NSDictionary *powerHook;
    MPMediaItem *song;
}

@property (nonatomic, strong) NSDictionary *powerHook;

@end
