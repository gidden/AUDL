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
@property (weak, nonatomic) IBOutlet UILabel *player1;
@property (weak, nonatomic) IBOutlet UILabel *player2;
@property (weak, nonatomic) IBOutlet UILabel *player3;
@property (weak, nonatomic) IBOutlet UILabel *player4;
@property (weak, nonatomic) IBOutlet UILabel *player5;
@property (weak, nonatomic) IBOutlet UILabel *player1No;
@property (weak, nonatomic) IBOutlet UILabel *player2No;
@property (weak, nonatomic) IBOutlet UILabel *player3No;
@property (weak, nonatomic) IBOutlet UILabel *player4No;
@property (weak, nonatomic) IBOutlet UILabel *player5No;

@end
