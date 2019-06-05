//
//  AppDelegate.swift
//  MightyTabBarExample
//
//  Created by Tim Shim on 6/4/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit
import MightyTabBar

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let tabBarController = MightyTabBarController()

        tabBarController.itemCountInRow = 5
        tabBarController.bgColor = .white
        tabBarController.handleColor = UIColor(displayP3Red: 149/255, green: 165/255, blue: 166/255, alpha: 0.5)

        tabBarController.tabBarItems = [
            ["name": "Home", "image": "home"],
            ["name": "Explore", "image": "rocket"],
            ["name": "Camera", "image": "camera"],
            ["name": "Gift", "image": "gift"],
            ["name": "Settings", "image": "gear"],
            ["name": "Award", "image": "gift"],
            ["name": "Profile", "image": "home"],
            ["name": "Gear", "image": "gear"],
            ["name": "Discover", "image": "rocket"],
            ["name": "Photos", "image": "camera"]
        ]

        let vc01 = ViewController01()
        let vc02 = ViewController02()
        let vc03 = ViewController03()
        let vc04 = ViewController04()
        let vc05 = ViewController05()
        let vc06 = ViewController06()
        let vc07 = ViewController07()
        let vc08 = ViewController08()
        let vc09 = ViewController09()
        let vc10 = ViewController10()
        tabBarController.viewControllers = [vc01, vc02, vc03, vc04, vc05, vc06, vc07, vc08, vc09, vc10]

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

