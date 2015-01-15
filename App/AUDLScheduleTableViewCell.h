//
//  AUDLScheduleTableViewCell.h
//  AUDL
//
//  Created by Ryan Zoellner on 4/9/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLScheduleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *teamOne;
@property (weak, nonatomic) IBOutlet UIImageView *teamOneIcon;
@property (weak, nonatomic) IBOutlet UILabel *teamTwo;
@property (weak, nonatomic) IBOutlet UIImageView *teamTwoIcon;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *teamOneScore;
@property (weak, nonatomic) IBOutlet UILabel *teamTwoScore; 
@property (weak, nonatomic) IBOutlet NSString *gameID;
@end
