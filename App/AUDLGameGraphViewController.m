//
//  AUDLGameGraphViewController.m
//  AUDL
//
//  Created by Patrick on 1/15/15.
//  Copyright (c) 2015 AUDL. All rights reserved.
//


#import "AUDLGameGraphViewController.h"
#import "CorePlot-CocoaTouch.h"

@implementation AUDLGameGraphViewController

- (void)awakeFromNib
{
    // Initialization code
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.gameID.text = self.gID;
    
    [self gameDataRequest];
    
    [self drawGraph];
    
}

-(void)drawGraph {
    
    CGRect frame = [[self view] bounds];
    frame.size.height = 200;
    
}
- (id)initWithID:(NSString *) ID
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.gID = ID;
    }
    
    NSLog(self.gID);
    return self;
 
    
}



- (void)gameDataRequest
{
    
    // Prepare the link that is going to be used on the GET request
    NSString *path = @"/Game";
    path = [path stringByAppendingString:self.gID];
    path = [path stringByAppendingString:@"/graph"];
    NSString *full_url = [server_url stringByAppendingString: path];
    NSURL * url = [[NSURL alloc] initWithString:full_url];
    
    // Prepare the request object
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                //cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                            timeoutInterval:30];
    
    // Prepare the variables for the JSON response
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    
    // Make synchronous request
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest
                                    returningResponse:&response
                                                error:&error];
    
    // Construct Array around the Data from the response
    self.gameData = [NSJSONSerialization
                 JSONObjectWithData:urlData
                 options:0
                 error:&error];
}

@end
