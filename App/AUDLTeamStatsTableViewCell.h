//
//  AUDLTeamStatsTableViewCell.h
//  AUDL
//
//  Created by Ryan Zoellner on 4/20/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLTeamStatsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stat;
@property (weak, nonatomic) IBOutlet UILabel *player;
@property (weak, nonatomic) IBOutlet UILabel *statVal;

@end
