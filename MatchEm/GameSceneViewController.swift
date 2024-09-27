//
//  ViewController.swift
//  MatchEm
//
//  Created by Nathaniel Capeta on 9/26/24.
//

import UIKit

class ViewController: UIViewController {
    
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
        let randWidth  = CGFloat.random(in: 50...150)
        let randHeight = CGFloat.random(in: 50...150)
        let randSize   = CGSize(width: randWidth, height: randHeight)
        let randColor  = UIColor(
            red:   CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue:  CGFloat.random(in: 0...1),
            alpha: 1.0
        )
        
        let rect  = UIView()
        rect.frame.size      = randSize
        rect.backgroundColor = randColor
        let x = CGFloat.random(in: self.view.frame.minX...(self.view.frame.maxX - randWidth))
        let y = CGFloat.random(in: self.view.safeAreaInsets.top...(self.view.frame.maxY - randHeight - self.view.safeAreaInsets.bottom))
        
        rect.frame.origin = CGPoint(x: x, y: y)
        view.addSubview(rect)
    }
}
