//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Debora Del Vecchio on 14/09/21.
//  Copyright © 2021 London App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogic {
    var number: Double?
    
    var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ newNumber: Double) {
        number = newNumber
    }
    
    mutating func calculate(symbol: String) -> Double? {
        if let n = number {
            switch symbol {
            case "AC":
                intermediateCalculation = nil
                return 0.0
            case "+/-":
                return -n
            case "%":
                return n / 100
            case "=":
                let result =  performTwoNumCalculation(n2: n)
                intermediateCalculation = nil
                return result
            default:
                if intermediateCalculation != nil {
                    let result = performTwoNumCalculation(n2: n)
                    if let r = result {
                        intermediateCalculation = (n1: r, calcMethod: symbol)
                        return r
                    }
                } else {
                    intermediateCalculation = (n1: n, calcMethod: symbol)
                }
            }
        }
        return nil
    }
    
    private func performTwoNumCalculation(n2: Double) -> Double? {
        if let n1 = intermediateCalculation?.n1,
           let operation = intermediateCalculation?.calcMethod {
            switch operation {
            case "+":
                return n1 + n2
            case "-":
                return n1 - n2
            case "÷":
                return n1 / n2
            case "×":
                return n1 * n2
            default:
                fatalError("The operation passed in does not match any of the cases.")
            }
        }
        return nil
    }
}
