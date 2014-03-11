//
//  BDAppDelegate.m
//  BackgroundDemo
//
//  Created by David G. Young on 11/6/13.
//  Copyright (c) 2013 RadiusNetworks. All rights reserved.
//

#import "BDAppDelegate.h"
#import "BDViewController.h"

@implementation BDAppDelegate
{
    CLLocationManager *_locationManager;
    BDViewController *_viewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    CLBeaconRegion *region;

    region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6"] major: 1 minor: 1 identifier: @"region1"];
    region.notifyEntryStateOnDisplay = YES;
    [_locationManager startMonitoringForRegion:region];
    [_locationManager stopRangingBeaconsInRegion:region];
    //[_locationManager startRangingBeaconsInRegion:region];

    region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6"] major: 1 minor: 2 identifier: @"region2"];
    region.notifyEntryStateOnDisplay = YES;
    [_locationManager startMonitoringForRegion:region];
    [_locationManager stopRangingBeaconsInRegion:region];
    //[_locationManager startRangingBeaconsInRegion:region];

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Display the main menu.
    _viewController = [[BDViewController alloc] init];
    
    self.window.rootViewController = _viewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [_viewController log:@"applicationDidFinishLaunching"];
    
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    if(state == CLRegionStateInside) {
        [_viewController log:[NSString stringWithFormat:@"locationManager didDetermineState INSIDE for %@", region.identifier]];
    }
    else if(state == CLRegionStateOutside) {
        [_viewController log:[NSString stringWithFormat:@"locationManager didDetermineState OUTSIDE for %@", region.identifier]];
    }
    else {
        [_viewController log:[NSString stringWithFormat:@"locationManager didDetermineState OTHER for %@", region.identifier]];
    }
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    // I commented out the line below because otherwise you see this every second in the logs
    // NSLog(@"locationManager didRangeBeacons");
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    [_viewController log:@"applicationWillResignActive"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [_viewController log:@"applicationDidEnterBackground"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [_viewController log:@"applicationWillEnterForeground"];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [_viewController log:@"applicationDidBecomeActive"];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [_viewController log:@"applicationWillTerminate"];
}

@end

