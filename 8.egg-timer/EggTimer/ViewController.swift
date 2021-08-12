//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerView: UIProgressView!
    
    let eggTimes: [String: Int]  = [
        "Soft": 3, //300,
        "Medium": 4, //420,
        "Hard": 7, //720,
    ]
    var timerTotalSeconds: Int = 0
    var timerSecondsRemaining: Int = 0
    var timerObject: Timer? = nil
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let hardness: String = sender.currentTitle!
        let seconds = eggTimes[hardness]!
        timerTotalSeconds = seconds
        timerSecondsRemaining = timerTotalSeconds
        if timerObject != nil {
            timerObject!.invalidate()
        }
        timerObject = startTimer()
        
    }
    
    func startTimer() -> Timer {
        return Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.updateProgressBar()
            if self.timerSecondsRemaining > 0 {
                self.timerSecondsRemaining -= 1
            } else {
                self.titleLabel.text = "Done"
                timer.invalidate()
            }
            
        }
    }
    
    func updateProgressBar() {
        let percentage = 1 - Float(timerSecondsRemaining) / Float(timerTotalSeconds)
        
        self.timerView.progress = percentage
        
    }
    
}
