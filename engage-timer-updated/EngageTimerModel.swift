//
//  EngageTimerModel.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 4/24/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import Foundation

class EngageTimer: ObservableObject {
    @Published var round = 2
    @Published var time = 10
    @Published var rest = 5
    @Published var timeStringDisplay = "0:10"
    @Published var restStringDisplay = "0:05"
    @Published var noiseTotal = 0
    @Published var noise = "Clap"
    @Published var buttonTitle = "Engage"
    @Published var timerIsRunning = false
    @Published private var showingAlert = false
    
    
    func integerToString (number: Int) -> String {

        let minutes = number / 60
        let seconds = String(number % 60)
        if seconds.count == 1 {
            let answer = "\(minutes):0\(seconds)"
            return answer
        } else {
            let answer = "\(minutes):\(seconds)"
            return answer
        }
    }
        
        func stringToInteger (string: String) -> Int {
            
            if let seconds = Int(string.suffix(2)), let minutes = Int(string.prefix(2)) {
                let minutesToSeconds = minutes * 60
                let answer = minutesToSeconds + seconds
                return answer
            }
            return 0
        }
}
