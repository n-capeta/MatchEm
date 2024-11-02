//
//  ConfigViewControllerDelegate.swift
//  MatchEm
//
//  Created by Nathaniel Capeta on 11/2/24.
//
import UIKit

protocol ConfigViewControllerDelegate: AnyObject {
    func updateValues(value: Double)
    func updateDark(value: Bool)
}
