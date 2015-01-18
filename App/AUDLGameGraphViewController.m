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
    
    // We need a hostview, you can create one in IB (and create an outlet) or just do this:
    CPTGraphHostingView* hostView = [[CPTGraphHostingView alloc] initWithFrame:self.view.frame];
    [self.view addSubview: hostView];
    
    // Create a CPTGraph object and add to hostView
    CPTGraph* graph = [[CPTXYGraph alloc] initWithFrame:hostView.bounds];
    hostView.hostedGraph = graph;
    
    // Get the (default) plotspace from the graph so we can set its x/y ranges
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    // Note that these CPTPlotRange are defined by START and LENGTH (not START and END) !!
    [plotSpace setYRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( 0 ) length:CPTDecimalFromFloat( 16 )]];
    [plotSpace setXRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( -4 ) length:CPTDecimalFromFloat( 8 )]];
    
    // Create the plot (we do not define actual x/y values yet, these will be supplied by the datasource...)
    CPTScatterPlot* plot = [[CPTScatterPlot alloc] initWithFrame:CGRectZero];
    
    // Let's keep it simple and let this class act as datasource (therefore we implemtn <CPTPlotDataSource>)
    plot.dataSource = self;
    
    // Finally, add the created plot to the default plot space of the CPTGraph object we created before
    [graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
    
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


// This method is here because this class also functions as datasource for our graph
// Therefore this class implements the CPTPlotDataSource protocol
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plotnumberOfRecords {
    return 9; // Our sample graph contains 9 'points'
}

// This method is here because this class also functions as datasource for our graph
// Therefore this class implements the CPTPlotDataSource protocol
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    // We need to provide an X or Y (this method will be called for each) value for every index
    int x = index - 4;
    
    // This method is actually called twice per point in the plot, one for the X and one for the Y value
    if(fieldEnum == CPTScatterPlotFieldX)
    {
        // Return x value, which will, depending on index, be between -4 to 4
        return [NSNumber numberWithInt: x];
    } else {
        // Return y value, for this example we'll be plotting y = x * x
        return [NSNumber numberWithInt: x * x];
    }
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
