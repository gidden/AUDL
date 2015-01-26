//
//  AUDLScoreTableViewCell.h
//  AUDL
//
//  Created by Patrick on 1/25/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLScoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *teamOne;
@property (weak, nonatomic) IBOutlet UIImageView *teamOneIcon;
@property (weak, nonatomic) IBOutlet UILabel *teamTwo;
@property (weak, nonatomic) IBOutlet UIImageView *teamTwoIcon;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *teamOneScore;
@property (weak, nonatomic) IBOutlet UILabel *teamTwoScore;
@property (strong, nonatomic) IBOutlet NSString *gameID;
@end
