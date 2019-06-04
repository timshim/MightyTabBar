//
//  ViewController.swift
//  DynamicTabBar
//
//  Created by Tim Shim on 6/1/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

class ViewController06: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Green Sea
        view.backgroundColor = UIColor(displayP3Red: 22/255, green: 160/255, blue: 133/255, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("vc06 appeared")
    }

}
