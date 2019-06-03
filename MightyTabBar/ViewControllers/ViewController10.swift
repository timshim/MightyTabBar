//
//  ViewController.swift
//  DynamicTabBar
//
//  Created by Tim Shim on 6/1/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

class ViewController10: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Midnight Blue
        view.backgroundColor = UIColor(displayP3Red: 44/255, green: 62/255, blue: 80/255, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("vc10 appeared")
    }

}
