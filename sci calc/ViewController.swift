//
//  ViewController.swift
//  sci calc
//
//  Created by dawei on 3/1/15.
//  Copyright (c) 2015 Vegan Revolution. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var brain = CalculatorBrain()
    var historyStack = [String]()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func appendHistory(sender: UIButton) {
        let opString = sender.currentTitle!
        historyStack.append(opString)
        history.text = history.text! + " " + opString
    }

    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue!) {
            displayValue = result
        } else {
            // assignment 2 puts error message here
            displayValue = 0
        }
    }

    var displayValue: Double? {
        get {
            if display.text! == "π" {
                return M_PI
            } else {
                if let number = NSNumberFormatter().numberFromString(display.text!)?.doubleValue {
                    return number
                } else {
                    return nil
                }
            }
        }
        set {
            display.text = "\(newValue!)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func allClear(sender: UIButton) {
        display.text = "0"
        history.text = " "
        historyStack.removeAll()
        userIsInTheMiddleOfTypingANumber = false
        brain.allClear()
    }
    
}

