//
//  AUDLStandingsTableViewCell.h
//  AUDL
//
//  Created by Ryan Zoellner on 4/10/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLStandingsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *teamName;
@property (weak, nonatomic) IBOutlet UILabel *record;
@property (weak, nonatomic) IBOutlet UILabel *pDiff;
@property (weak, nonatomic) IBOutlet UILabel *element3;
@end
