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

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func appendDecimalPoint(sender: UIButton) {
        if userInTheMiddleOfTypingANumber {
            if display.text?.rangeOfString(".") == nil {
                display.text = display.text! + "."
            }
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            history.text = "\(history.text!) \(operation)"
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userInTheMiddleOfTypingANumber = false
        history.text = "\(history.text!) \(display.text!)"
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userInTheMiddleOfTypingANumber = false
        }
    }
}