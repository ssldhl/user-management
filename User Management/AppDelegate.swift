//
//  AppDelegate.swift
//  User Management
//
//  Created by Sushil Dahal on 10/21/15.
//  Copyright © 2015 Sushil Dahal. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var drawerContainer: MMDrawerController?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        
        var keys: NSDictionary?
        
        if let path = NSBundle.mainBundle().pathForResource("keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        
        if keys != nil {
            let applicationId = keys?["parseApplicationId"] as? String
            let clientKey = keys?["parseClientKey"] as? String
            
            Parse.setApplicationId(applicationId!, clientKey: clientKey!)
        }
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        buildUI()
        
        return true
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

    func buildUI(){
        let username = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
        
        if(username != nil){
            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let home:HomeViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
            let menu: MenuViewController = storyBoard.instantiateViewControllerWithIdentifier("MenuViewController") as! MenuViewController
            let options: OptionsViewController = storyBoard.instantiateViewControllerWithIdentifier("OptionsViewController") as! OptionsViewController
            
            let homeNavigation = UINavigationController(rootViewController: home)
            let menuNavigation = UINavigationController(rootViewController: menu)
            let optionsNavigation = UINavigationController(rootViewController: options)
            
            drawerContainer = MMDrawerController(centerViewController: homeNavigation, leftDrawerViewController: menuNavigation, rightDrawerViewController: optionsNavigation)
            drawerContainer?.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
            drawerContainer?.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView
            
            window?.rootViewController = drawerContainer
        }
    }

}

