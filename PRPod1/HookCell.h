//
//  HookCell.h
//  PRPod1
//
//  Created by Adam Roth on 1/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HookCell : UITableViewCell {
    NSDictionary *song;
    IBOutlet UIButton *playButton;
    IBOutlet UILabel *artistLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *rangeLabel;
}

@property (nonatomic, strong) NSDictionary *song;
@property (nonatomic, strong) IBOutlet UIButton *playButton;
@property (nonatomic, strong) IBOutlet UILabel *artistLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *rangeLabel;

- (IBAction)pressPlay:(id)sender;

@end
