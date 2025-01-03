//
//  ViewController.swift
//  MatchEm
//
//  Created by Nathaniel Capeta on 9/26/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, ConfigViewControllerDelegate {
    @IBOutlet weak var infoLabel: UILabel!
    var musicPlayer: AVAudioPlayer?
    
    var darkMode : Bool = false
    var timer: Double = 12.0
    var rectSpawnVal: Double = 1
    
    var startGameBtn : UIButton?
    var firstBtnTouch: UIButton?
    
    var rectBtnMap: [UIButton: Int] = [:]
    var btnInd = 0
    
    var isGamePaused = false
    var gameTimer: Timer?
    var hasGameStarted = false
    
    func updateRectSpawn(value: Double) {
        self.rectSpawnVal = (50 / value)
    }
    
    func updateDark(value: Bool){
        self.darkMode = value
        view.backgroundColor = self.darkMode ? UIColor.lightGray : UIColor.white
    }
    
    func updateTimer(value: Double){
        self.timer = value
    }
    
    func updateMusic(value: Bool){
        if value {
            musicPlayer?.pause()
        } else {
            musicPlayer?.play()
        }
    }
    
    func startBackgroundMusic(){
        guard let url = Bundle.main.url(forResource: "background", withExtension: "mp3") else { return }
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer?.numberOfLoops = -1
            musicPlayer?.play()
        } catch {
            print("Error loading audio file: \(error)")
        }
    }
    
    var score = 0 {
        didSet {
            self.infoLabel.text = labelText(self.time, self.score, self.pairCount)
        }
    }
    var time = 12.0 {
        didSet {
            self.infoLabel.text = labelText(self.time, self.score, self.pairCount)
        }
    }
    
    var pairCount = 0 {
        didSet {
            self.infoLabel.text = labelText(self.time, self.score, self.pairCount)
        }
    }
    
    var labelText = {(_ time: Double,_ score: Int,_ pairCount: Int)-> String in
        return "Time: \(Int(time)) - Score: \(score) - Pairs Created: \(pairCount)"
    }
    
    override func viewDidLoad() {
        print ("View Loaded")
        super.viewDidLoad()
        
        self.infoLabel.text = labelText(self.time, self.score, self.pairCount)
        
        startBackgroundMusic()
        
        let twoFingerTap = UITapGestureRecognizer(target: self, action: #selector(startGameWithTwoFingerTap))
        twoFingerTap.numberOfTouchesRequired = 2
        view.addGestureRecognizer(twoFingerTap)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pauseGame()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isGamePaused && hasGameStarted {
            resumeGame()
        }
    }
    
    @objc func startGameWithTwoFingerTap() {
        if !hasGameStarted {
            gameStart()
        } else if isGamePaused {
            resumeGame()
        } else {
            pauseGame()
        }
    }
    
    func gameStart() {
        print("Game started")
        print(self.rectSpawnVal)
        hasGameStarted = true
        
        // Resetting score, time, and counts
        score     = 0
        pairCount = 0
        time      = timer
        isGamePaused = false
        
        // Schedule the game timer
        gameTimer = Timer.scheduledTimer(withTimeInterval: rectSpawnVal, repeats: true) { timer in
            if self.time > 0 {
                self.time -= self.rectSpawnVal
                self.makeRectPair()
            } else {
                timer.invalidate()
                self.gameEnd()
            }
        }
    }

    func pauseGame() {
        print("Game paused")
        // Set game to paused
        isGamePaused = true
        // Invalidate timer
        gameTimer?.invalidate()
    }

    func resumeGame() {
        print("Game resumed")
        isGamePaused = false
        
        // Restart the timer
        gameTimer = Timer.scheduledTimer(withTimeInterval: rectSpawnVal, repeats: true) { timer in
            if self.time > 0 {
                self.time -= self.rectSpawnVal
                self.makeRectPair()
            } else {
                timer.invalidate()
                self.gameEnd()
            }
        }
    }
    
    
    func makeRectPair(){
        print ("Make rect pair")
        let randWidth  = CGFloat.random(in: 50...150)
        let randHeight = CGFloat.random(in: 50...150)
        let randColor  = UIColor(
            red:   CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue:  CGFloat.random(in: 0...1),
            alpha: 1.0
        )
        
        let x  = CGFloat.random(in: self.view.frame.minX...(self.view.frame.maxX - randWidth))
        let y  = CGFloat.random(in: self.view.safeAreaInsets.top...(self.view.frame.maxY - randHeight -
                                                                    self.view.safeAreaInsets.bottom))
        let x2 = CGFloat.random(in: self.view.frame.minX...(self.view.frame.maxX - randWidth))
        let y2 = CGFloat.random(in: self.view.safeAreaInsets.top...(self.view.frame.maxY - randHeight -
                                                                    self.view.safeAreaInsets.bottom))
        let frame  = CGRect(x: x,  y: y,  width: randWidth, height: randHeight)
        let frame2 = CGRect(x: x2, y: y2, width: randWidth, height: randHeight)
        
        let rectBtn  = UIButton(frame: frame)
        let rect2Btn = UIButton(frame: frame2)
        rectBtn.backgroundColor  = randColor
        rect2Btn.backgroundColor = randColor
        
        rectBtn.addTarget(self, action: #selector(buttonSelect(_:)), for: .touchUpInside)
        rect2Btn.addTarget(self, action: #selector(buttonSelect(_:)), for: .touchUpInside)
        
        self.view.addSubview(rectBtn)
        self.view.addSubview(rect2Btn)
        rectBtnMap[rectBtn]  = btnInd
        rectBtnMap[rect2Btn] = btnInd
        btnInd += 1
        pairCount += 1
    }
    
    @objc func buttonSelect(_ sender: UIButton){
        // Check to see if a button is currently stored
        // Also check if the button is going to be pressed twice
        if firstBtnTouch == nil || firstBtnTouch == sender{
            // Store the pressed button and highlihgt
            print  ("Storing first button")
            firstBtnTouch = sender
            sender.setTitle("🕺", for: .normal)
            sender.layer.borderColor = UIColor.black.cgColor
            sender.layer.borderWidth = 5.0
            
        // If not it's the second button pressed
        } else {
            // Gather the indexes for the two buttons that have been pressed
            let btn1PressInd = rectBtnMap[firstBtnTouch!]
            let btn2PressInd = rectBtnMap[sender]
            // Check indexes against each other
            if (btn1PressInd == btn2PressInd){
                // Correct pair - remove from view and clear firstBtnTouch
                print ("Successful pair found")
                firstBtnTouch!.removeFromSuperview()
                sender.removeFromSuperview()
                firstBtnTouch = nil // Clear selected
                score += 1
                
            } else {
                // Incorrect pair - clear button selection
                print ("Failed pair")
                firstBtnTouch!.setTitle("", for: .normal)
                firstBtnTouch!.layer.borderColor = UIColor.clear.cgColor
                firstBtnTouch!.layer.borderWidth = 0
                firstBtnTouch = nil // Clear selected
            }
        }
    }
    
    func resetButtons(){
        for (button, _) in rectBtnMap {
            button.removeFromSuperview()
        }
        rectBtnMap.removeAll()
        print ("Buttons removed")
    }
    
    func gameEnd(){
        resetButtons()
        btnInd = 0
        print("Game Over")
        gameTimer?.invalidate()
        gameTimer = nil
        hasGameStarted = false
        
        // Save the current score to GameManager and get top scores
        GameManager.shared.addScore(score)
    }
}
