//
//  ResultsViewController.swift
//  BMI Calculator
//
//  Created by Debora Del Vecchio on 13/08/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var bmiValue = "0.0"
    var bmiAdvice = ""
    var bmiColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

    @IBOutlet private weak var bmiLabel: UILabel!
    @IBOutlet private weak var adviceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bmiLabel.text = bmiValue
        adviceLabel.text = bmiAdvice
        view.backgroundColor = bmiColor
    }
    

    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
