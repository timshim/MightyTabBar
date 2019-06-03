//
//  ViewController.swift
//  DynamicTabBar
//
//  Created by Tim Shim on 6/1/19.
//  Copyright © 2019 Tim Shim. All rights reserved.
//

import UIKit

class ViewController05: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Wet Asphalt
        view.backgroundColor = UIColor(displayP3Red: 52/255, green: 73/255, blue: 94/255, alpha: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("vc05 appeared")
    }

}
