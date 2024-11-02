//
//  ConfigViewControllerDelegate.swift
//  MatchEm
//
//  Created by Nathaniel Capeta on 11/2/24.
//
import UIKit

protocol ConfigViewControllerDelegate: AnyObject {
    func updateRectSpawn(value: Double)
    
    func updateDark(value: Bool)
    
    func updateTimer(value: Double)
    
    func updateMusic(value: Bool)
}
