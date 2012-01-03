//
//  HookCell.m
//  PRPod1
//
//  Created by Adam Roth on 1/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HookCell.h"
#import "PRAppDelegate.h"
#import "NSDictionary+Song.h"

@implementation HookCell

@synthesize playButton, artistLabel, titleLabel, rangeLabel, song;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)pressPlay:(id)sender {
    PRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate playSong:self.song onComplete:nil];
}

@end
