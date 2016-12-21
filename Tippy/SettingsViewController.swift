//
//  SettingsViewController.swift
//  Tippy
//
//  Created by Sarah Gemperle on 12/13/16.
//  Copyright © 2016 Sarah Gemperle. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //Main View outlets: step counter, the rate Label container, and the segment controlling the color.
    @IBOutlet weak var stepCounter: UIStepper!
    @IBOutlet weak var tipRateLabel: UILabel!
    @IBOutlet weak var colorSegment: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Override viewWillAppear
    //Purpose: Updates screen to display the previous values input by user. Sets the default tip rate as well as the default color choice to what the user previously picked as the default.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Access defaults, set the current tip rate value and color selection to the previously picked user options.
        let defaults = UserDefaults.standard
        let tipValue = defaults.double(forKey: "default_tip_percentage")
        let colorNum = defaults.integer(forKey: "default_color")
        
        stepCounter.value = tipValue
        tipRateLabel.text = String.init(format: "%.0f", tipValue)
        tipRateLabel.text = tipRateLabel.text! + "%"
        colorSegment.selectedSegmentIndex = colorNum
    }

    //Override viewWillDisappear
    //Purpose: Set the newly picked defaults to what the user changes.
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        let tipPerc = stepCounter.value //new value if changed
        let colorNum = colorSegment.selectedSegmentIndex //new color value if changed
        
        //Access defaults and update/sync
        let defaults = UserDefaults.standard
        defaults.set(tipPerc, forKey: "default_tip_percentage")
        defaults.set(colorNum, forKey: "default_color")
        defaults.synchronize()
    }
    
    //Function: valChanged
    //Purpose: To update the tipRateLabel on the settings screen as user increases or decreases step counter.
    @IBAction func valChanged(_ sender: AnyObject) {
        let perc = stepCounter.value
        tipRateLabel.text = String.init(format: "%.0f", perc)
        tipRateLabel.text = tipRateLabel.text! + "%"
    }

}
