//
//  AUDLTableViewCell.h
//  App
//
//  Created by Ryan Zoellner on 3/20/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLTableViewCell : UITableViewCell

@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *teamId;
@property (strong, nonatomic) NSString *teamName;
@property (strong, nonatomic) NSString *date;
@property (nonatomic, strong) NSArray *divSchedule;
@property (nonatomic, strong) NSArray *divScores;
@property (nonatomic, strong) NSArray *divTeams;
@property (strong, nonatomic) NSString *divisionName;
@property (strong, nonatomic) NSString *videoId;
@property (strong, nonatomic) NSString *Setting;
@property (strong, nonatomic) NSString *cellIdentifier;


@end
