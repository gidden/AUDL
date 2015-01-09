//
//  AUDLAppDelegate.h
//  App
//
//  Created by Ryan Zoellner on 3/13/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"

@interface AUDLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSDictionary *icons;
@property (strong, nonatomic) NSArray *teamsData;
@property (strong, nonatomic) NSMutableArray *teamIds;
@property (strong, nonatomic) NSMutableArray *teamIcons;

@end
