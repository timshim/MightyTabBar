//
//  ViewController.swift
//  DynamicTabBar
//
//  Created by Tim Shim on 6/1/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

class ViewController07: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Nephritis
        view.backgroundColor = UIColor(displayP3Red: 39/255, green: 174/255, blue: 96/255, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("vc07 appeared")
    }

}
