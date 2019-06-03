//
//  ViewController.swift
//  DynamicTabBar
//
//  Created by Tim Shim on 6/1/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

class ViewController03: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Peter River
        view.backgroundColor = UIColor(displayP3Red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("vc03 appeared")
    }

}
