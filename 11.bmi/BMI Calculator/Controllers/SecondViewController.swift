//
//  SecondViewController.swift
//  BMI Calculator
//
//  Created by Debora Del Vecchio on 13/08/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    var bmiValue = "0.0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.text = "Hello"
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.addSubview(label)
    }
}
