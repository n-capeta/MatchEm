//
//  CustomTabBarController.swift
//  MatchEm
//
//  Created by Nathaniel Capeta on 10/31/24.
//

import UIKit

class CustomTabBarController: UITabBarController
{
    @IBInspectable var initialIndex: Int = 1
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        selectedIndex = initialIndex
        
        if let matchEmVC = viewControllers?[1] as? ViewController,
           let configVC = viewControllers?[0] as? ConfigViewController {
            configVC.delegate = matchEmVC
        }
    }
}
