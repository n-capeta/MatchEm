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

class GameManager: ConfigViewControllerDelegate {
    static let shared = GameManager() // Singleton pattern for global access
    
    private init() {} // Prevent external initialization

    // Variables for configuration settings
    var rectSpawnRate: Double = 1.0
    var isDarkModeEnabled: Bool = false
    var gameTimer: Double = 60.0
    var isMusicEnabled: Bool = true

    // High scores data
    private var scores: [Int] = [0, 0, 0]
    
    func addScore(_ score: Int) {
        scores.append(score)
        scores.sort(by: >) // Sort scores in descending order
    }
    
    func getTopScores() -> [Int] {
        return Array(scores.prefix(3)) // Return the top 3 scores
    }

    func updateRectSpawn(value: Double) {
        rectSpawnRate = value
    }

    func updateDark(value: Bool) {
        isDarkModeEnabled = value
    }

    func updateTimer(value: Double) {
        gameTimer = value
    }

    func updateMusic(value: Bool) {
        isMusicEnabled = value
    }
}
