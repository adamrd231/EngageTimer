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
    
    // State variable to countdown rounds instead of counting up
    @Published var totalRounds = UserDefaults.standard.integer(forKey: "totalRounds") {
        didSet {
            UserDefaults.standard.set(self.totalRounds, forKey: "totalRounds")
        }
    }
    
    @Published var time = UserDefaults.standard.integer(forKey: "time") {
        didSet {
//         Check to make sure the random count wont crash the app
            if randomCountSpeed == 3 {
                if time / 10 < noiseTotal {
                    noiseTotal = time / 10
                }
            } else if randomCountSpeed == 2 {
                if time / 5 < noiseTotal {
                    self.noiseTotal = time / 5
                }
            } else if randomCountSpeed == 1 {
                if time - 3 < noiseTotal {
                    noiseTotal = time - 3
                }
            }
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
                // Check to make sure the random count wont crash the app
                if randomCountSpeed == 3 {
                    if time / 10 < noiseTotal {
                        noiseTotal = time / 10
                    }
                } else if randomCountSpeed == 2 {
                    if time / 5 < noiseTotal {
                        noiseTotal = time / 5
                    }
                } else if randomCountSpeed == 1 {
                    if time - 3 < noiseTotal {
                        noiseTotal = time - 3
                    }
                }
            UserDefaults.standard.set(self.noiseTotal, forKey: "noiseTotal")
        }
    }
    
    @Published var randomCountSpeed: Float  = UserDefaults.standard.float(forKey: "randomCountSpeed") {
        didSet {
                // Check to make sure the random count wont crash the app
                if randomCountSpeed == 3 {
                    if time / 10 < noiseTotal {
                        noiseTotal = time / 10
                    }
                } else if randomCountSpeed == 2 {
                    if time / 5 < noiseTotal {
                        noiseTotal = time / 5
                    }
                } else if randomCountSpeed == 1 {
                    if time - 3 < noiseTotal {
                        noiseTotal = time - 3
                    }
                }
            UserDefaults.standard.set(self.randomCountSpeed, forKey: "randomCountSpeed")
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
        var range = time - 2
        
        
        
        if noiseTotal == 0 {
            return
        }
        
        for _ in 1...noiseTotal {
            randomNumber = Int.random(in: 1...range)
            
            if randomCountSpeed == 1 {
                print("using random count = 1")
               // 1 second minmum between each count
               while randomArray.contains(randomNumber) {
                   randomNumber = Int.random(in: 1...range)
               }
            } else if randomCountSpeed == 2 {
                print("using random count = 3")
                // 4 second minmum between each count
                while randomArray.contains(randomNumber) || randomArray.contains(randomNumber - 1) || randomArray.contains(randomNumber + 1) || randomArray.contains(randomNumber - 2) || randomArray.contains(randomNumber + 2)  {
                    randomNumber = Int.random(in: 1...range)
                }
            } else if randomCountSpeed == 3 {
                range = time - 5
                
                print("using random count = 5")
               while randomArray.contains(randomNumber) || randomArray.contains(randomNumber - 1) || randomArray.contains(randomNumber + 1) || randomArray.contains(randomNumber - 2) || randomArray.contains(randomNumber + 2) || randomArray.contains(randomNumber + 3) || randomArray.contains(randomNumber - 3) || randomArray.contains(randomNumber + 4) || randomArray.contains(randomNumber - 4) || randomArray.contains(randomNumber + 5) || randomArray.contains(randomNumber - 5) {
                    randomNumber = Int.random(in: 2...range)
                }
            }
           
            // check if the random number generated matches any of the numbers in the random array
            // check to see if the random number matches any of the surrounding numbers in the random array
            // allow user to set range of how many numbers are checked
            randomArray.append(randomNumber)
            
            
//            while randomArray.contains(randomNumber) {
//                randomNumber = Int.random(in: 2...range)
//            }
//
//
//            randomArray.append(randomNumber)
            
        }
        print(randomArray)
    }
    
}
