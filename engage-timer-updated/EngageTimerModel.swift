//
//  EngageTimerModel.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 4/24/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import Foundation
import GoogleMobileAds

class EngageTimer: ObservableObject, Identifiable {
    
    @Published var round = 1
    
    @Published var prepCountDown = UserDefaults.standard.integer(forKey: "prepCountDown") {
        didSet {
            UserDefaults.standard.set(self.prepCountDown, forKey: "prepCountDown")
        }
    }
    
    @Published var usingPrepCountDown = UserDefaults.standard.bool(forKey: "usingPrepCountDown") {
        didSet {
            UserDefaults.standard.set(self.usingPrepCountDown, forKey: "usingPrepCountDown")
        }
    }
    // State variable to countdown rounds instead of counting up
    @Published var totalRounds = UserDefaults.standard.integer(forKey: "totalRounds") {
        didSet {
            UserDefaults.standard.set(self.totalRounds, forKey: "totalRounds")
        }
    }
    
    @Published var time = UserDefaults.standard.integer(forKey: "time") {
        didSet {
//         Check to make sure the random count wont crash the app
//            if randomCountSpeed == 3 {
//                if time / 10 < noiseTotal {
//                    noiseTotal = time / 10
//                }
//            } else if randomCountSpeed == 2 {
//                if time / 5 < noiseTotal {
//                    self.noiseTotal = time / 5
//                }
//            } else if randomCountSpeed == 1 {
//                if time - 3 < noiseTotal {
//                    noiseTotal = time - 3
//                }
//            }
            UserDefaults.standard.set(self.time, forKey: "time")
        }
    }
    
    @Published var rest = UserDefaults.standard.integer(forKey: "rest") {
        didSet {
            UserDefaults.standard.set(self.rest, forKey: "rest")
        }
    }
    
    
    @Published var usingRandomNoise = UserDefaults.standard.bool(forKey: "usingRandomNoise") {
        didSet {
            UserDefaults.standard.set(self.usingRandomNoise, forKey: "usingRandomNoise")
        }
    }
    
    @Published var noiseChoice = UserDefaults.standard.integer(forKey: "noiseChoice") {
        didSet {
            UserDefaults.standard.set(self.noiseChoice, forKey: "noiseChoice")
        }
    }
    
    @Published var noiseArray = ["Clap", "Bell", "Whistle"]
    @Published var buttonTitle = "Engage"
    @Published var timerIsRunning = false
    @Published var pauseButtonTitle = "Pause"
    
    // Reset Values
    @Published var timeReset = 0
    @Published var restReset = 0
    @Published var roundReset = 0
    @Published var noiseCountReset = 0
    @Published var prepCountDownReset = 0
    
    // Random Array and Random Number Placeholder used to create random sequence.
    @Published var randomArray:[Int] = []
    @Published var randomNumber = 1
    @Published var lowerRange = 1
    @Published var upperRange = 5
    @Published var countingNumber = 1
    @Published var randomCount = 1
    
    
    
    // Functions
    func resetAllValues() {
        round = roundReset
        time = timeReset
        rest = restReset
        // noiseTotal = noiseCountReset
        
        // Reset Rounds
        round = roundReset
        
        // Reset Noise Total
        // noiseTotal = noiseCountReset
        prepCountDown = prepCountDownReset
    }
    
    func resetPrepCount() {
        prepCountDown = prepCountDownReset
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
        // noiseCountReset = noiseTotal
        prepCountDownReset = prepCountDown
        randomCount = randomArray.count
    }

    func resetRandomNoiseCount() {
        // noiseTotal = noiseCountReset
    }

        
    func createRandomNumberArray() {
        randomArray = []

        while countingNumber < time {
            let randomNumber = Int.random(in: lowerRange...upperRange)
            countingNumber += randomNumber
            randomArray.append(countingNumber)
        }
        print(randomArray)
    }
    
}
