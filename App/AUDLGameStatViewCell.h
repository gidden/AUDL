
//
//  AUDLStatTable.h
//  AUDL
//
//  Created by Patrick on 2/8/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface AUDLGameStatViewCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UILabel *team1Stat;
@property (strong,nonatomic) IBOutlet UILabel *statName;
@property (strong,nonatomic) IBOutlet UILabel *team2Stat;
@end