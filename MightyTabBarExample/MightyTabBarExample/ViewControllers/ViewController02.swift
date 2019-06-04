//
//  ViewController.swift
//  DynamicTabBar
//
//  Created by Tim Shim on 6/1/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

class ViewController02: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Emerald
        view.backgroundColor = UIColor(displayP3Red: 46/255, green: 204/255, blue: 113/255, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("vc02 appeared")
    }

}
