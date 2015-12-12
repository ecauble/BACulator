//
//  AppDelegate.swift
//  BACulator
//
//  Created by Eric Cauble on 10/7/15.
//  Copyright © 2015 Oopie Doopie. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let defaults = DefaultsManager()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // set if app launched from shorcut with boolean
        var appLaunchedFromShortCut = false
        // check current shortcut item
        if let currentShorcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            appLaunchedFromShortCut = true
            QuickActionsForItem(currentShorcutItem)
        }
        
        let rootNavigationController = window!.rootViewController as? UINavigationController
        let tabbarController = window!.rootViewController as? UITabBarController
        
        // if needed pop to root view controller
        rootNavigationController?.popToRootViewControllerAnimated(false)
        
        // navigate to proper view controller after reading defaults
        if(defaults.isSet(K_GENDER) && defaults.isSet(K_WEIGHT)){
            tabbarController!.selectedViewController = tabbarController!.viewControllers?[1]
        }
        else{
            tabbarController!.selectedViewController = tabbarController!.viewControllers?[0]
        }
        return !appLaunchedFromShortCut
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
//MARK: - Handle QuickActions For ShorCut Items -> AppDelegate Extension
typealias HandleForShorCutItem = AppDelegate
extension HandleForShorCutItem {
    
    /// Define quick actions type
    enum QuickActionsType: String {
        case Settings =     "quickactions.BACulator.settings"
        case Add =          "quickactions.BACulator.add"
        
    }
    
    
    /// Shortcut Item, also called a Home screen dynamic quick action, specifies a user-initiated action for app.
    func QuickActionsForItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        // set handled boolean
        var isHandled = false
        
        // Get the string type from shorcut item
        if let shorchutItemType = QuickActionsType.init(rawValue: shortcutItem.type) {
            
            // Get root navigation controller + root tab bar controller
            let rootNavigationController = window!.rootViewController as? UINavigationController
            let tabbarController = window!.rootViewController as? UITabBarController
            // if needed pop to root view controller
            rootNavigationController?.popToRootViewControllerAnimated(false)
            
            // return tabbarcontroller selected
            switch shorchutItemType {
            case .Add:
                tabbarController!.selectedViewController = tabbarController!.viewControllers?[1]
                isHandled = true
            case .Settings:
                tabbarController!.selectedViewController = tabbarController!.viewControllers?[2]
                isHandled = true
                
            }
        }
        return isHandled
    }
    
    /// Calls - user selects a Home screen quick action for app
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        // perform action for shortcut item selected
        let handledShortCutItem = QuickActionsForItem(shortcutItem)
        completionHandler(handledShortCutItem)
    }
    
}

