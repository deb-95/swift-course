//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    let images: [String] = ["DiceOne",  "DiceTwo", "DiceThree", "DiceFour", "DiceFive", "DiceSix",]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        let max = images.count - 1
        let dice1Index = Int.random(in: 0...max)
        let dice2Index = Int.random(in: 0...max)
        diceImageView1.image = UIImage(named: images[dice1Index])
        diceImageView2.image = UIImage(named: images[dice2Index])
    }
    
}

