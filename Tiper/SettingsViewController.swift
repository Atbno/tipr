//
//  SettingsViewController.swift
//  Tiper
//
//  Created by Ansh Nanda on 7/15/20.
//  Copyright © 2020 Ansh Nanda. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    //Access UserDefaults
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set an Integer value for some key.
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "defaultTip")
        defaults.synchronize()
        
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        // Set an Integer value for some key.
        defaults.set(tipControl.selectedSegmentIndex, forKey: "defaultTip")
        print("Settings")
        print(defaults.integer(forKey: "defaultTip"))
        defaults.synchronize()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
