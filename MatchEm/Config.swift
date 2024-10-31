//
//  Config.swift
//  MatchEm
//
//  Created by Nathaniel Capeta on 10/31/24.
//

import UIKit

class Config: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print("Slider value: \(sender.value)")
    }

    @IBAction func darkModeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            print("Dark Mode ON")
        } else {
            print("Dark Mode OFF")
        }
    }
    
}
