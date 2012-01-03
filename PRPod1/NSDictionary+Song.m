//
//  NSDictionary+Song.m
//  PRPod1
//
//  Created by Adam Roth on 1/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+Song.h"

@implementation NSDictionary (Song)

- (MPMediaItemCollection *) asMediaItemCollection {
    MPMediaQuery *query = [MPMediaQuery songsQuery];   
    [query addFilterPredicate:[MPMediaPropertyPredicate predicateWithValue:[self objectForKey:@"persistentID"] forProperty:MPMediaItemPropertyPersistentID comparisonType:MPMediaPredicateComparisonEqualTo]];
    [query setGroupingType:MPMediaGroupingTitle];
        
    return [[MPMediaItemCollection alloc] initWithItems:[NSArray arrayWithObject:[query.items objectAtIndex:0]]];
}

@end
