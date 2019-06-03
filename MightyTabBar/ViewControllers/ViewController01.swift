//
//  ViewController.swift
//  DynamicTabBar
//
//  Created by Tim Shim on 6/1/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

class ViewController01: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Turquoise
        view.backgroundColor = UIColor(displayP3Red: 26/255, green: 188/255, blue: 156/255, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("vc01 appeared")

        if let tabBarController = parent as? MightyTabBarController {
            tabBarController.setBadge(count: 1, index: 9)
        }
    }

}
