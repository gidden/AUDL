//
//  AUDLFAQViewController.m
//  AUDL
//
//  Created by Evan Rypel on 4/20/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLFAQViewController.h"

@interface AUDLFAQViewController ()

@end

@implementation AUDLFAQViewController

- (id)initWithString:(NSString *)str
{
    self = [super init];
    NSLog(@"init faqviewcontroller");
    if (self) {
        // Initialization code
        _message = [[UITextView alloc] init];
        
        _message.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        _message.backgroundColor = [UIColor whiteColor];
        
        _message.userInteractionEnabled = NO;
        [[self view] addSubview:_message];
         NSLog(@"%@",self.view.subviews);
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
