//
//  BDViewController.m
//  BackgroundDemo
//
//  Created by David G. Young on 11/6/13.
//  Copyright (c) 2013 RadiusNetworks. All rights reserved.
//

#import "BDViewController.h"

@interface BDViewController ()

@end

@implementation BDViewController

UILabel *label;
NSString *logString;

- (void)viewDidLoad
{
    [super viewDidLoad];
	label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,480)];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines=0;
    label.font=[label.font fontWithSize:14];
    [self.view addSubview:label];
    logString = @"";
}

- (void)log: (NSString *) line {
    NSLog(line);
    NSDate *now = [NSDate date];

    /*
     //Create the dateformatter object
     NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
     
     //Set the required date format
     [formatter setDateFormat:@"yyyy-MM-dd HH:MM:SS"];
     
     //Get the string date
     NSString* str = [formatter stringFromDate:date];
    */
    logString = [NSString stringWithFormat:@"%@\r%@ %@", logString, now, line];
    //logString = [NSString stringWithFormat:@"\r\n%@", line];
    NSLog(@"Logstring is now %@ with length %d", logString, logString.length);
    [label setText: logString];
    [label sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
