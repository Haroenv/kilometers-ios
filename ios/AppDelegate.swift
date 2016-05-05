//
//  AppDelegate.swift
//
//  Created by Haroen Viaene on 02/05/16.
//

import UIKit
import CoreLocation
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate  {

    var window: UIWindow?
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    let locationManager = CLLocationManager()
    
    let root = Firebase(url: "https://kilometers.firebaseio.com")
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        root.observeAuthEventWithBlock({ authData in
            if authData != nil {
            } else {
                let homeViewController = self.mainStoryboard.instantiateViewControllerWithIdentifier("MainView")
                self.window?.rootViewController?.presentViewController(homeViewController, animated: true, completion: nil)
            }
        })
        
        // Request permission to present notifications
        let notificationSettings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        // Request background location permissions and register for visit monitoring
        //locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        //locationManager.startMonitoringVisits()
        
        return true
    }
    
    func locationManager(manager: CLLocationManager, didVisit visit: CLVisit) {
        showNotification("Visit: \(visit)")
    }
    
    func showNotification(body: String) {
        let notification = UILocalNotification()
        notification.alertAction = nil
        notification.alertBody = body
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

