//
//  AUDLTop5TableViewCell.h
//  AUDL
//
//  Created by Evan Rypel on 4/19/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLTop5TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end
