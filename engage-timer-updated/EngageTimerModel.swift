//
//  EngageTimerModel.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 4/24/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import Foundation
import GoogleMobileAds

class EngageTimer: ObservableObject {
    @Published var round = 1
    
    // State variable to countdown rounds instead of counting up
    @Published var totalRounds = UserDefaults.standard.integer(forKey: "totalRounds") {
        didSet {
            UserDefaults.standard.set(self.totalRounds, forKey: "totalRounds")
        }
    }
    
    @Published var time = UserDefaults.standard.integer(forKey: "time") {
        didSet {
            UserDefaults.standard.set(self.time, forKey: "time")
        }
    }
    
    @Published var rest = UserDefaults.standard.integer(forKey: "rest") {
        didSet {
            UserDefaults.standard.set(self.rest, forKey: "rest")
        }
    }
    
    @Published var noiseTotal = UserDefaults.standard.integer(forKey: "noiseTotal") {
        didSet {
            UserDefaults.standard.set(self.noiseTotal, forKey: "noiseTotal")
        }
    }
    
    @Published var noise = "Clap"
    @Published var usingRandomNoise = true
    
    @Published var noiseArray = ["Clap", "Bell", "Whistle"]
    @Published var buttonTitle = "Engage"
    @Published var timerIsRunning = false
    
    @Published var pauseButtonTitle = "Pause"
    @Published var timeReset = 0
    @Published var restReset = 0
    @Published var roundReset = 0
    @Published var noiseCountReset = 0
    
    @Published var randomArray:[Int] = []
    @Published var randomNumber = 1
    
    
    
    func resetAllValues() {
        round = roundReset
        time = timeReset
        rest = restReset
        noiseTotal = noiseCountReset
        // Reset Rounds
        round = roundReset
        // Reset Noise Total
        noiseTotal = noiseCountReset
    }

    func resetTimeAndRest() {
        // Reset the time
        time = timeReset
        // Display Time in clock format
        
        // Reset the Rest
        rest = restReset
        // Display Rest in clock format
        
    }

    func fillResetValues() {
        roundReset = round
        timeReset = time
        restReset = rest
        noiseCountReset = noiseTotal
    }

    func resetRandomNoiseCount() {
        noiseTotal = noiseCountReset
    }

        
    func createRandomNumberArray() {
        randomArray = []
        let range = time - 3
        
        for _ in 1...noiseTotal {
            randomNumber = Int.random(in: 2...range)
            
            while randomArray.contains(randomNumber) || randomArray.contains(randomNumber + 1) || randomArray.contains(randomNumber - 1) || randomArray.contains(randomNumber + 2) || randomArray.contains(randomNumber - 2) {
                randomNumber = Int.random(in: 2...range)
            }
            randomArray.append(randomNumber)
            
        }
    }
    
}
