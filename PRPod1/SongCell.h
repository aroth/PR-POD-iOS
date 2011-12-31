//
//  songCell.h
//  PRPod
//
//  Created by Adam Roth on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongCell : UITableViewCell {
    IBOutlet UIButton *playButton;
    IBOutlet UILabel *songLabel;
    IBOutlet UIButton *addButton;
}
@property (nonatomic, strong) IBOutlet UIButton *playButton;
@property (nonatomic, strong) IBOutlet UIButton *addButton;
@property (nonatomic, strong) IBOutlet UILabel *songLabel;

@end
