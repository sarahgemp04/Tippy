//
//  ViewController.swift
//  Tippy
//
//  Created by Sarah Gemperle on 12/13/16.
//  Copyright © 2016 Sarah Gemperle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var stepCounter: UIStepper!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipRateLabel: UILabel!
    @IBOutlet weak var billLabel: UITextField!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Function: onTap
    //Purpose: to remove keyboard when user taps anywhere on screen.
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    //Function: editingChanged
    //Purpose: to change both the tipRate, tip amount, and total amount after user changes either the step count value or the bill amount.
    @IBAction func editingChanged(_ sender: AnyObject) {
        let bill = Double(billLabel.text!) ?? 0
        let tipPerc = stepCounter.value
        let tip = bill * (tipPerc/100)
        let total = bill + tip
        
        tipRateLabel.text = String.init(format: "%.0f", tipPerc)
        tipRateLabel.text = tipRateLabel.text! + "%"
        tipLabel.text = String.init(format: "$%.2f", tip)
        totalLabel.text = String.init(format: "$%.2f", total)
    }
    
    //Override viewWillAppear
    //Purpose: Initializes tip rate to default, and background color to default. Also edits the tip amount and total amount if default is different than previous tip rate. --Resets bill amount to 0 if idle for 10 min+
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        let tipValue = defaults.double(forKey: "default_tip_percentage")
        let colorNum = defaults.double(forKey: "default_color")
        
        if(colorNum == 0) {
            view1.backgroundColor = UIColor.init(red: 0.715938, green: 0.853208, blue: 0.811129, alpha: 0.815517)
            view2.backgroundColor = UIColor.init(red: 0.569542, green: 0.799007, blue: 0.815672, alpha: 0.534995)
        }
        else {
            view1.backgroundColor = UIColor.lightGray
            view2.backgroundColor = UIColor.init(white: 0.971, alpha: 0.732)
        }
        
        stepCounter.value = tipValue
        editingChanged(stepCounter)
      
        if(defaults.object(forKey: "timeSince") != nil ) {
            
            let currDate = Date.init()
            let prevDate = defaults.object(forKey: "timeSince") as! Date
            let timeInterval = currDate.timeIntervalSince(prevDate)
            
            if(timeInterval >= 600) {
                billLabel.text = ""
                editingChanged(billLabel)
            }
            
        }
        billLabel.becomeFirstResponder()
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        }
    
    //Override viewDidDisapper
    //Purpose: save current date to Defaults when the view disappears to check if longer than 10 minutes when reappears.
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        print("view did disappear")
        let defaults = UserDefaults.standard
        let date = Date.init()
        print(date)
        defaults.set(date, forKey: "timeSince")

    }
}

