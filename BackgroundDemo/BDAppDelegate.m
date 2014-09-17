//
//  BDAppDelegate.m
//  BackgroundDemo
//
//  Created by David G. Young on 11/6/13.
//  Copyright (c) 2013 RadiusNetworks. All rights reserved.
//

#import "BDAppDelegate.h"


@implementation BDAppDelegate
{
    CLLocationManager *_locationManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.internalLog = [[NSMutableArray alloc] init];
    [self logString: @"applicationDidFinishLaunching"];
    

    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    CLBeaconRegion *region;

    region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6"] major: 2764 minor: 1 identifier: @"region1"];
    region.notifyEntryStateOnDisplay = YES;
    [_locationManager startMonitoringForRegion:region];
    [_locationManager stopRangingBeaconsInRegion:region];
    [_locationManager startRangingBeaconsInRegion:region];
    
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    if(state == CLRegionStateInside) {
        NSLog(@"locationManager didDetermineState INSIDE for %@", region.identifier);
        [self logString: [NSString stringWithFormat:@"locationManager didDetermineState INSIDE for %@", region.identifier]];

    }
    else if(state == CLRegionStateOutside) {
        [self logString: [NSString stringWithFormat:@"locationManager didDetermineState OUTSIDE for %@", region.identifier]];
    }
    else {
        [self logString: [NSString stringWithFormat:@"locationManager didDetermineState OTHER for %@", region.identifier]];
    }
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    // I commented out the line below because otherwise you see this every second in the logs
    [self logString: [NSString stringWithFormat:@"locationManager didRangeBeacons"]];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    [self logString: [NSString stringWithFormat:@"applicationWillResignActive"]];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self logString: [NSString stringWithFormat:@"applicationDidEnterBackground"]];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self logString: [NSString stringWithFormat:@"applicationWillEnterForeground"]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self logString: [NSString stringWithFormat:@"applicationDidBecomeActive"]];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self logString: [NSString stringWithFormat:@"applicationWillTerminate"]];
}

-(void)logString: (NSString *)str {
    NSDate *now = [NSDate date];
    NSString *lineToLog = [NSString stringWithFormat: @"%@ %@", now, str];
    [self.internalLog addObject: lineToLog];
    NSLog(lineToLog);
}

@end

