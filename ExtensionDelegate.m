//
//  ExtensionDelegate.m
//  Notifications WatchKit Extension
//
//  Created by Christian Lauer on 14.12.16.
//  Copyright © 2016 Christian Lauer. All rights reserved.
//

#import "ExtensionDelegate.h"
#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "setGoal.h"
//#import "PCKInterfaceControllerLoader.h"

@implementation ExtensionDelegate


- (void)applicationDidFinishLaunching {
    // Perform any final initialization of your application.
}

- (void)applicationDidBecomeActive {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillResignActive {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, etc.
}

- (void)handleBackgroundTasks:(NSSet<WKRefreshBackgroundTask *> *)backgroundTasks {
    // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
    for (WKRefreshBackgroundTask * task in backgroundTasks) {
        // Check the Class of each task to decide how to process it
        if ([task isKindOfClass:[WKApplicationRefreshBackgroundTask class]]) {
            // Be sure to complete the background task once you’re done.
            WKApplicationRefreshBackgroundTask *backgroundTask = (WKApplicationRefreshBackgroundTask*)task;
            [backgroundTask setTaskCompleted];
        } else if ([task isKindOfClass:[WKSnapshotRefreshBackgroundTask class]]) {
            // Snapshot tasks have a unique completion call, make sure to set your expiration date
            WKSnapshotRefreshBackgroundTask *snapshotTask = (WKSnapshotRefreshBackgroundTask*)task;
            [snapshotTask setTaskCompletedWithDefaultStateRestored:YES estimatedSnapshotExpiration:[NSDate distantFuture] userInfo:nil];
        } else if ([task isKindOfClass:[WKWatchConnectivityRefreshBackgroundTask class]]) {
            // Be sure to complete the background task once you’re done.
            WKWatchConnectivityRefreshBackgroundTask *backgroundTask = (WKWatchConnectivityRefreshBackgroundTask*)task;
            [backgroundTask setTaskCompleted];
        } else if ([task isKindOfClass:[WKURLSessionRefreshBackgroundTask class]]) {
            // Be sure to complete the background task once you’re done.
            WKURLSessionRefreshBackgroundTask *backgroundTask = (WKURLSessionRefreshBackgroundTask*)task;
            [backgroundTask setTaskCompleted];
        } else {
            // make sure to complete unhandled task types
            [task setTaskCompleted];
        }
    }
}

//Handle Local Notification Actions
-(void)handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UNNotification *)localNotification{
    
    //Always opens the interface
    //The app calls this method when the user taps an action button in an alert displayed in response to a local notification. Local notifications that include a registered category name in their category property display buttons for the actions in that category. If the user taps one of those buttons, the system wakes up the app (launching it if needed) and calls this method in the background. Your implementation of this method should perform the action associated with the specified identifier and execute the block in the completionHandler parameter as soon as you are done. Failure to execute the completion handler block at the end of your implementation will cause your app to be terminated.
    
    //If Pairing amphiro was clicked -> Try to get iOS back in active/Foreground
    if([identifier isEqualToString:@"action"]){
        //Setup WCSession
        if ([WCSession isSupported]) {
            [[WCSession defaultSession] setDelegate:self];
            [[WCSession defaultSession] activateSession];
            
            //Get the value from slider
            NSString *someString = [[NSUserDefaults standardUserDefaults]
                                    stringForKey:@"Update"];
            NSString *Update = @"Update";
            NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[Update] forKeys:@[@"Update"]];
            //Send Message to the iPhone (handle over the goal value)
            [[WCSession defaultSession] sendMessage:applicationData
                                       replyHandler:^(NSDictionary *reply) {
                                           //handle reply from iPhone app here
                                       }
                                       errorHandler:^(NSError *error) {
                                           //catch any errors here
                                       }
             ];
        }
    }
    
    //If Goal Setting was clicked
    if([identifier isEqualToString:@"action3"]){
        

    }
}



@end
