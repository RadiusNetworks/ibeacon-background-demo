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
    UIBackgroundTaskIdentifier _backgroundTask;
    Boolean _inBackground;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.internalLog = [[NSMutableArray alloc] init];
    [self logString: @"applicationDidFinishLaunching"];

    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestAlwaysAuthorization];
    _locationManager.delegate = self;
    CLBeaconRegion *region;

    region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6"] major: 1 minor: 1 identifier: @"region1"];
    region.notifyEntryStateOnDisplay = YES;
    [_locationManager startMonitoringForRegion:region];
    [_locationManager stopRangingBeaconsInRegion:region];
    [_locationManager startRangingBeaconsInRegion:region];
    _backgroundTask = UIBackgroundTaskInvalid;
    _inBackground = YES;

    
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
    if (_inBackground) {
        [self extendBackgroundRunningTime];
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
    [self extendBackgroundRunningTime];
    _inBackground = YES;
}


- (void)extendBackgroundRunningTime {
    if (_backgroundTask != UIBackgroundTaskInvalid) {
        // if we are in here, that means the background task is already running.
        // don't restart it.
        return;
    }
    NSLog(@"Attempting to extend background running time");
    
    __block Boolean self_terminate = YES;
    
    _backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithName:@"DummyTask" expirationHandler:^{
        NSLog(@"Background task expired by iOS");
        if (self_terminate) {
            [[UIApplication sharedApplication] endBackgroundTask:_backgroundTask];
            _backgroundTask = UIBackgroundTaskInvalid;
        }
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Background task started");
        
        while (true) {
            NSLog(@"background time remaining: %8.2f", [UIApplication sharedApplication].backgroundTimeRemaining);
            [NSThread sleepForTimeInterval:1];
        }
        
    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self logString: [NSString stringWithFormat:@"applicationWillEnterForeground"]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self logString: [NSString stringWithFormat:@"applicationDidBecomeActive"]];
    _inBackground = NO;
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

