//
//  AUDLGameTabView.h
//  AUDL
//
//  Created by Patrick on 2/6/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface AUDLGameTabView : UITabBarController

@property (strong, nonatomic) NSString *gameID;

- (id)initWithGameID:(NSString *) ID;

@end