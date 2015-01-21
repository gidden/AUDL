//
//  AUDLNewsTableViewCell.h
//  AUDL
//
//  Created by Patrick on 1/20/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLNewsTableViewCell : UITableViewCell

@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *artTitle;


@end
