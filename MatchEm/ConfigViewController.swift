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
    
    @IBOutlet weak var GameTimeLabel: UILabel!
    @IBOutlet weak var GameTimeStepper: UIStepper!
    
    @IBOutlet weak var gameHistory: UILabel!
    
    
    override func viewDidLoad()
    {
        print("Config View Loaded")
        super.viewDidLoad()
        GameTimeStepper.minimumValue = 1
        GameTimeStepper.maximumValue = 60
        GameTimeStepper.stepValue = 1
        GameTimeStepper.value = 12
        GameTimeLabel.text = "\(GameTimeStepper.value)"

    }
    
    override func viewWillAppear(_ animated: Bool){
        let topScores = GameManager.shared.getTopScores()
        
        gameHistory.text = "Top scores: \(topScores[0]), \(topScores[1]), \(topScores[2])"
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        delegate?.updateRectSpawn(value: Double(sender.value))
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
    
    @IBAction func muteSwitch(_ sender: UISwitch) {
        if sender.isOn {
            print("Unmute")
            delegate?.updateMusic(value: sender.isOn)
        } else {
            print("Mute")
            delegate?.updateMusic(value: sender.isOn)
        }
    }
    
    @IBAction func stepperUsed(_ sender: UIStepper) {
        GameTimeLabel.text = "\(sender.value)"
        delegate?.updateTimer(value: sender.value)
    }
}


