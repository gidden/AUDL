//
//  AUDLNowViewController.m
//  App
//
//  Created by Evan Rypel on 3/22/14.
//  Copyright (c) 2014 AUDL. All rights reserved.
//

#import "AUDLNowViewController.h"
#import "SWRevealViewController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "STTwitter.h"
#import "AUDLTwitterViewCell.h"
//#import <Twitter/Twitter.h>

@interface AUDLNowViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *twitterTableView;
@property (strong, nonatomic) NSMutableArray *twitterFeed;


@end

@implementation AUDLNowViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    //change color of button
    _sidebarButton.tintColor = [UIColor colorWithRed:0 green:122.0/225.0 blue:1.0 alpha:1.0];
    //set side bar button acton. when tapped, sidebar appears
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    //set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
   
//  STTwitterAPI *twitter = [STTwitterAPI twitterAPIAppOnlyWithConsumerKey:@"3egMgWgj6UXp7N3eh9VP5Q" consumerSecret:@"BoWTmMYa8CL2mDxNS7mAYcDHWJ5o5ah7ndqvpsaFA"];

    //register with the view cell class
//    [self.tableView registerNib:[UINib nibWithNibName:@"AUDLTwitterViewCell" bundle:nil] forCellReuseIdentifier:@"TwitterCellID"];
//    self.tableView.rowHeight = 120;
//
//    
//    [twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
//        [twitter getUserTimelineWithScreenName:@"theAUDL" successBlock:^(NSArray *statuses){
//            self.twitterFeed = [NSMutableArray arrayWithArray:statuses];
//            
//            [self.tableView reloadData];
//        } errorBlock:^(NSError *error){
//            NSLog(@"%@", error.debugDescription);
//        }];
//    }
//    
//errorBlock:^(NSError *error){
//    NSLog(@"%@", error.debugDescription);
//}];

}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    UIWebView *webView = [[UIWebView alloc] init];
    [webView setFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://mobile.twitter.com/theaudl"]]];
    
    [[self view] addSubview:webView];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.twitterFeed.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"TwitterCellID";
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    AUDLTwitterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[AUDLTwitterViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
//    if(cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//        
//    }
    NSInteger index = indexPath.row;
    NSDictionary *t = self.twitterFeed[index];
    NSLog(t[@"text"]);
    cell.feedText.text = [NSString stringWithFormat:@"%@",t[@"text"]];
    //cell.textLabel.text = t[@"text"];

    //cell.twitterIcon.image = [UIImage imageNamed:@"Twitter_bird_logo.png"];
    //cell.AUDLIcon.image = [UIImage imageNamed:@"audl-120.png"];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
