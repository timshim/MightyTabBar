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
        tabBarController.selectedColor = .red
        tabBarController.deselectedColor = .black

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

}
