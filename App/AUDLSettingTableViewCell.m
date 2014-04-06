//
//  AUDLSettingTableViewCell.m
//  App
//
//  Created by Evan Rypel on 3/21/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLSettingTableViewCell.h"

@implementation AUDLSettingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
