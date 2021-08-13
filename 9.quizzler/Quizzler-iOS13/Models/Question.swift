//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Debora Del Vecchio on 13/08/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    init(q: String, a: String) {
        self.question = q
        self.answer = a
    }
    
    let question: String
    let answer: String
}
