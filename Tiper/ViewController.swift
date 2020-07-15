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
    @IBOutlet weak var splitStepper: UIStepper!
    @IBOutlet weak var tipAmountLabel: UILabel!
    let pasteboard = UIPasteboard.general
    
    // getting local currency info
    var currencySymbol:String = "$"
    let currencyFormatter = NumberFormatter()
    
    //Access UserDefaults
    let defaults = UserDefaults.standard
    
    // Global tip percentages
    let tipPercentage = [0.15,0.18,0.2]

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set an Integer value for some key.
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTip")
        defaults.synchronize()
        
        realTipCalculation()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        billAmountTextField.becomeFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tipr"
        
        // remove state if app has been in background for over 10 minutes
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: nil) { (notification) in
            print("BACKGROUND")
            UserDefaults.standard.set(Date(), forKey: "timeElapsed")
            let timeElapsed = UserDefaults.standard.object(forKey: "timeElapsed") as! Date
            print(Date().timeIntervalSince(timeElapsed))
        }
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { (notification) in
            print("ACTIVE")
            let timeElapsed = UserDefaults.standard.object(forKey: "timeElapsed") as! Date
            print(Date().timeIntervalSince(timeElapsed))
            
            if (Date().timeIntervalSince(timeElapsed) >  600){
                self.clearFields()
            }
        }

        
        // getting local currency info
        let locale = Locale.current
        currencySymbol = locale.currencySymbol!
        
        // currency formatter
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = locale

        
        
        // permanent changes
        totalView.layer.cornerRadius = 10;
        totalView.layer.masksToBounds = true;
        billAmountTextField.keyboardType = UIKeyboardType.decimalPad
        splitStepper.value = 1
        splitStepper.minimumValue = 1
        splitStepper.maximumValue = 9
        
        // loading defaults
        tipAmountLabel.text = currencySymbol + "0.00"
        tipPercentageLabel.text = String(format: "%d", Int(tipPercentage[tipControl.selectedSegmentIndex] * 100)) + "%"
        totalLabel.text = currencySymbol + "0.00"
        billAmountTextField.placeholder = "0.00"
        splitLabel.text = "1"
        

    }
    
    
    @IBAction func onTap(_ sender: Any) {
        billAmountTextField.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        realTipCalculation()
    }
    
    func realTipCalculation() {
        let bill = Double(billAmountTextField.text!) ?? 0
        let splitBetween = splitStepper.value
        
        let tip = bill * tipPercentage[tipControl.selectedSegmentIndex]
        let total = (bill + tip) / splitBetween
        
        tipAmountLabel.text =  String(format:" %.2f", tip / splitBetween)
        tipPercentageLabel.text = String(format: "%d", Int(tipPercentage[tipControl.selectedSegmentIndex] * 100)) + "%"
        totalLabel.text = currencyFormatter.string(from: NSNumber(value: total))
        splitLabel.text = Int(splitStepper.value).description
    }
    
    @IBAction func copyToClipboard(_ sender: Any) {
        pasteboard.string = totalLabel.text
    }
    
    func clearFields() {
        tipAmountLabel.text = currencySymbol + "0.00"
        tipPercentageLabel.text = String(format: "%d", Int(tipPercentage[tipControl.selectedSegmentIndex] * 100)) + "%"
        totalLabel.text = currencySymbol + "0.00"
        billAmountTextField.placeholder = "0.00"
        splitLabel.text = "1"
        billAmountTextField.text = ""
    }
    
}

