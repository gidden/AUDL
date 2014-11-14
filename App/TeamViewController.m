//
//  TeamViewController.m
//  App
//
//  Created by Evan Rypel on 3/30/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "TeamViewController.h"

@interface TeamViewController ()

@end

@implementation TeamViewController
//@synthesize teamName;

- (id)initWithTeam:(NSArray *)teamList
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.teamList = teamList;
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

-(void)indivTeamRequest
{
    
    ////add team's name to the url
   // NSURL * url = [[NSURL alloc] initWithString:[@"http://ec2-54-86-111-95.us-west-2.compute.amazonaws.com:4001/" stringByAppendingString:teamName]];
    //NSLog(@"%@",teamName);
    //NSLog(@"%@",url);
    
    //NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                //cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                //cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                            //timeoutInterval:30];
    
    // Prepare the variables for the JSON response
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    // Make synchronous request
    //urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    //returningResponse:&response
                                               // error:&error];
    
    //problem here parsing team info
    //indivTeam = [NSJSONSerialization
                  //JSONObjectWithData:urlData
                  //options:0
                  //error:&error];
    //int i = 10;
   // i + 8;
    
}

@end
