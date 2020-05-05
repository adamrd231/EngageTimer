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
    @Published var round = 3
    @Published var time = 10
    @Published var rest = 5
    @Published var noiseTotal = 2
    @Published var noise = "Clap"
    @Published var usingRandomNoise = true
    @Published var noiseArray = ["Clap", "Bell", "Whack"]
    @Published var buttonTitle = "Engage"
    @Published var timerIsRunning = false
    
    @Published var pauseButtonTitle = "Pause"
    @Published var timeReset = 0
    @Published var restReset = 0
    @Published var roundReset = 0
    @Published var noiseCountReset = 0
    
    @Published var randomArray:[Int] = []
    @Published var randomNumber = 1
    
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common)
    

    
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
        time = self.timeReset
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

    func instanstiateTimer() {
        timerIsRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
        return
    }

    func cancelTimer() {
        timer.connect().cancel()
        timerIsRunning = false
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
