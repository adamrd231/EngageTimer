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
}
