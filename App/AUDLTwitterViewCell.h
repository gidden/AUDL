//
//  AUDLTwitterViewCell.h
//  AUDL
//
//  Created by Patrick on 1/13/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLTwitterViewCell : UITableViewCell

@property (weak
           , nonatomic) IBOutlet UILabel *feedText;

@property (weak, nonatomic) NSString *tweetLink;

@end
