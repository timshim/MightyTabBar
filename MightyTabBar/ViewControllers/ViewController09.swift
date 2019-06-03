//
//  ViewController.swift
//  DynamicTabBar
//
//  Created by Tim Shim on 6/1/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

class ViewController09: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Wisteria
        view.backgroundColor = UIColor(displayP3Red: 142/255, green: 68/255, blue: 173/255, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("vc09 appeared")
    }

}
