//
//  NotificationController.m
//  Notifications WatchKit Extension
//
//  Created by Christian Lauer on 14.12.16.
//  Copyright © 2016 Christian Lauer. All rights reserved.
//

#import "NotificationController.h"


@interface NotificationController()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *labelAlert;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *alertBody;

@end


@implementation NotificationController

- (instancetype)init {
    self = [super init];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}



- (void)didReceiveNotification:(UNNotification *)notification withCompletion:(void(^)(WKUserNotificationInterfaceType interface)) completionHandler {

    // This method is called when a notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}


                              
//Ui-Local -> deplaced in new Version
-(void)didReceiveLocalNotification:(UILocalNotification *)localNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler{
    // This method is called when a notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    NSDictionary *dict = [localNotification userInfo];
    NSString *alertTitle = localNotification.alertTitle;
    [_labelAlert setText:alertTitle];
    NSString *alertBody = localNotification.alertBody;
    [_alertBody setText:alertBody];
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}





@end



