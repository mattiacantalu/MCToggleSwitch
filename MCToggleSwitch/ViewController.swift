//
//  ViewController.swift
//  MCToggleSwitch
//
//  Created by Mattia Cantalù on 25/09/2017.
//  Copyright © 2017 Mattia Cantalù. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MCToggleSwitchDelegate {
      override func viewDidLoad() {
        super.viewDidLoad()
        let toggle = MCToggleSwitch(frame: CGRect(x: 100,
                                                  y: 100,
                                                  width: 51,
                                                  height: 31))
        self.view.addSubview(toggle)
    }
}

