//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    var storyBrain = StoryBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    @IBAction func onChoiceSelected(_ sender: UIButton) {
        storyBrain.nextStory(choice: sender.currentTitle!)
        sender.alpha = 0.5
        Timer.scheduledTimer(
            withTimeInterval: 0.2,
            repeats: false,
            block: {
                (timer) in
                sender.alpha = 1
            })
        updateUI()
        
    }
    
    func updateUI() {
        let currentStory = storyBrain.getCurrentStory()
        storyLabel.text = storyBrain.getStoryTitle()
        choice1Button.setTitle(currentStory.choice1, for: .normal)
        choice2Button.setTitle(currentStory.choice2, for: .normal)
    }
}

