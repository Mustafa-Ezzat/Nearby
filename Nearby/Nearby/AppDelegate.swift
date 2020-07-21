//
//  AppDelegate.swift
//  Nearby
//
//  Created by Mustafa Ezzat on 7/16/20.
//  Copyright © 2020 foursquare. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: LaunchCoordinator?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        startLaunchScene()
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func startLaunchScene() {
        let navigationController = NavigationController()
        coordinator = LaunchCoordinator(navigationController: navigationController)
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator?.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
