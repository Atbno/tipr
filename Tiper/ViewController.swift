//
//  ViewController.swift
//  Tiper
//
//  Created by Ansh Nanda on 7/12/20.
//  Copyright © 2020 Ansh Nanda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var totalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup
        totalView.layer.cornerRadius = 10;
        totalView.layer.masksToBounds = true;
        tipPercentageLabel.text = "10%"
        totalLabel.text = "0.00"
        billAmountTextField.placeholder = "0.00"
        billAmountTextField.keyboardType = UIKeyboardType.decimalPad
    }
    
    
    @IBAction func onTap(_ sender: Any) {
        billAmountTextField.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentage = [0.15,0.18,0.2]
        
        let tip = bill * tipPercentage[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipPercentageLabel.text = String(format: "0%.2f", tip)
        totalLabel.text = String(format: "0%.2f", total)
    }
    
    @IBAction func onIncrement(_ sender: UIStepper) {
        splitLabel.text = Int(sender.value).description
    }
}

