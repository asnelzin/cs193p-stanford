//
//  ViewController.swift
//  Calculator
//
//  Created by Nelzin Alexander on 03.02.15.
//  Copyright (c) 2015 asnelzin. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    
    var userInTheMiddleOfTypingANumber: Bool = false
    
    var brain = CalcultorBrain()
    
    var displayValue: Double {
        get {
            return (display.text! as NSString).doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userInTheMiddleOfTypingANumber {
            display.text! += digit
        } else {
            display.text = digit
            userInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func appendDecimalPoint(sender: UIButton) {
        if userInTheMiddleOfTypingANumber {
            if display.text?.rangeOfString(".") == nil {
                display.text! += "."
            }
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if let operation = sender.currentTitle {
            self.updateHistory(operation)
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userInTheMiddleOfTypingANumber = false
        self.updateHistory(display.text!)
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    @IBAction func clear(sender: UIButton) {
        brain.clearStack()
        displayValue = 0
        history.text! = ""
    }
    
    func updateHistory(newValue: String) {
        history.text = "\(history.text!) \(newValue)"
    }
}