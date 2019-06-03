//
//  ViewController.swift
//  DynamicTabBar
//
//  Created by Tim Shim on 6/1/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

class ViewController04: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Amethyst
        view.backgroundColor = UIColor(displayP3Red: 155/255, green: 89/255, blue: 182/255, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("vc04 appeared")
    }

}
