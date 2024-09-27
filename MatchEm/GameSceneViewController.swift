//
//  ViewController.swift
//  MatchEm
//
//  Created by Nathaniel Capeta on 9/26/24.
//

import UIKit

class ViewController: UIViewController {
    
    var firstBtnTouch: UIButton?
    var rectBtnMap: [UIButton: Int] = [:]
    var btnInd = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("View Loaded")
        // Do any additional setup after loading the view.
    }

    @IBAction func startGame(_ sender: UIButton) {
        sender.isHidden = true; // Hide button after clicked
        startGame()
    }
    
    func startGame(){
        print ("Game started")
        makeRectPair()
        
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
    }
    
    @objc func buttonSelect(_ sender: UIButton){
        if firstBtnTouch == nil || firstBtnTouch == sender{
            firstBtnTouch = sender
            sender.setTitle("🕺", for: .normal)
            sender.layer.borderColor = UIColor.black.cgColor
            sender.layer.borderWidth = 5.0
        } else {
            let btn1PressInd = rectBtnMap[firstBtnTouch!]
            let btn2PressInd = rectBtnMap[sender]
            if (btn1PressInd == btn2PressInd){
                firstBtnTouch!.removeFromSuperview()
                sender.removeFromSuperview()
                firstBtnTouch = nil // Clear selected
                makeRectPair()
                makeRectPair()
            } else {
                firstBtnTouch!.setTitle("", for: .normal)
                firstBtnTouch!.layer.borderColor = UIColor.clear.cgColor
                firstBtnTouch!.layer.borderWidth = 0
                firstBtnTouch = nil // Clear selected
            }
        }
        /*
        sender.isSelected.toggle()
        if sender.isSelected {
        }
         */
        
    }
}
