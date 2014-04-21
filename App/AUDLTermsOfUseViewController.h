//
//  AUDLTermsOfUseViewController.h
//  AUDL
//
//  Created by Evan Rypel on 4/21/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUDLTermsOfUseViewController : UIViewController

@property (nonatomic, strong) UITextView *message;

- (id)initWithString:(NSString *)str;

@end
