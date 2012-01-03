//
//  NSDictionary+Song.h
//  PRPod1
//
//  Created by Adam Roth on 1/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MediaPlayer/MPMusicPlayerController.h"

@interface NSDictionary (Song)

- (MPMediaItemCollection *) asMediaItemCollection;


@end
