//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

enum PercentButtonEnum: Int {
    case Zero
    case Ten
    case Twenty
}

let tipsMap = [PercentButtonEnum.Zero.rawValue: 0, PercentButtonEnum.Ten.rawValue: 0.1, PercentButtonEnum.Twenty.rawValue: 0.2]

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!

    var tip = 0.0
    var peopleNumber = 2
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zeroPctButton.isSelected = true
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        switch sender.tag {
                case PercentButtonEnum.Zero.rawValue:
                    zeroPctButton.isSelected = true
                    tenPctButton.isSelected = false
                    twentyPctButton.isSelected = false
                case PercentButtonEnum.Ten.rawValue:
                    zeroPctButton.isSelected = false
                    tenPctButton.isSelected = true
                    twentyPctButton.isSelected = false
                case PercentButtonEnum.Twenty.rawValue:
                    zeroPctButton.isSelected = false
                    tenPctButton.isSelected = false
                    twentyPctButton.isSelected = true
                default:
                    zeroPctButton.isSelected = false
                    tenPctButton.isSelected = false
                    twentyPctButton.isSelected = false
            }
        tip = tipsMap[sender.tag]!
    }

    @IBAction func splitChanged(_ sender: UIStepper) {
        billTextField.endEditing(true)
        splitNumberLabel.text = "\(Int(sender.value))"
        peopleNumber = Int(sender.value)
    }

    @IBAction func calculatePressed(_ sender: UIButton) {
        calculateSplitValue()
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    func calculateSplitValue() {
        let valueToSplit = ((billTextField.text ?? "0") as NSString).doubleValue
        let numberResult = (valueToSplit + valueToSplit * tip) / Double(peopleNumber)
        result = String(format: "%.2f", numberResult)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "goToResults" {
                let destinationVC = segue.destination as! ResultViewController
                destinationVC.result = result
                destinationVC.tip = Int(tip * 100)
                destinationVC.split = peopleNumber
            }
        }
    
    
}

