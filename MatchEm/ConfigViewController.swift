//
//  Config.swift
//  MatchEm
//
//  Created by Nathaniel Capeta on 10/31/24.
//

import UIKit

class ConfigViewController: UIViewController
{
    weak var delegate: ConfigViewControllerDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        delegate?.updateValues(value: Double(sender.value))
        print("Slider value: \(sender.value)")
    }

    @IBAction func darkModeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            print("Dark Mode ON")
            delegate?.updateDark(value: sender.isOn)
            view.backgroundColor = UIColor.lightGray
        } else {
            print("Dark Mode OFF")
            delegate?.updateDark(value: sender.isOn)
            view.backgroundColor = UIColor.white
        }
    }
    
}
