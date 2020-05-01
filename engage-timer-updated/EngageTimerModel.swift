//
//  EngageTimerModel.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 4/24/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import Foundation

class EngageTimer: ObservableObject {
    @Published var round = 3
    @Published var time = 10
    @Published var rest = 5
    @Published var noiseTotal = 0
    @Published var noise = "Clap"
    @Published var buttonTitle = "Engage"
    @Published var timerIsRunning = false
    @Published private var showingAlert = false
    
    func checkNoiseCount() {
        if noiseTotal > time / 5 {
            noiseTotal = time / 5
        }
    }

}
