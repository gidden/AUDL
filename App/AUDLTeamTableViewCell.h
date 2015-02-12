
//
//  AUDLTeamTableViewCell.h
//  AUDL
//
//  Created by Patrick on 2/11/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface AUDLTeamTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *teamLogo;
@property (strong, nonatomic) IBOutlet UIImageView *bgView;
@property (strong, nonatomic) IBOutlet UIImageView *dividerView;

@property (strong, nonatomic) IBOutlet UILabel *teamName;
@property (strong, nonatomic) NSString *teamId;

@end