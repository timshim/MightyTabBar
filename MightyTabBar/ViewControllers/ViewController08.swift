//
//  ViewController.swift
//  DynamicTabBar
//
//  Created by Tim Shim on 6/1/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

class ViewController08: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Belize Hole
        view.backgroundColor = UIColor(displayP3Red: 41/255, green: 128/255, blue: 185/255, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("vc08 appeared")
    }

}
