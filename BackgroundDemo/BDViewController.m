//
//  BDViewController.m
//  BackgroundDemo
//
//  Created by David G. Young on 11/6/13.
//  Copyright (c) 2013 RadiusNetworks. All rights reserved.
//

#import "BDViewController.h"
#import "BDAppDelegate.h"

@interface BDViewController ()

@end

@implementation BDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchDumpLog:(id)sender {
    BDAppDelegate *appDelegate = (BDAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"--------------");
    NSString * combinedLog = [appDelegate.internalLog componentsJoinedByString:@"\n"];
    NSLog(combinedLog);
    NSLog(@"--------------");

}
@end
