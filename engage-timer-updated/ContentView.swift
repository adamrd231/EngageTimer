//
//  ContentView.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 2/6/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //Properties
    // =========
    @State var round = 2
    @State var timeStringDisplay = "3:00"
    @State var restStringDisplay = "1:00"
    @State var noiseTotal = 0
    @State var noise = "Clap"
    
    @State var buttonTitle = "Engage"
    @State var timerIsRunning = false
    
    @State var time = 10
    @State var rest = 5
    
    @State private var showingAlert = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common)
    
    // ================================================================
    
    // User Interface Views
    var body: some View {
        VStack(alignment: .center) {
            
        // Rounds Stack
        // =============================
            VStack {
                Text("ROUND")
                    .font(.subheadline)
                
                // Rounds Remaining
                Text("\(self.round)").font(.custom("DS-Digital", size: 80)).fixedSize()
            }.padding(.bottom)
            
        // Time Remaining Stack
        // ====================
            VStack {
                // Time description
                Text("TIME")
                    .font(.subheadline)
                
                // Time Remaining
                Text("\(self.timeStringDisplay)").font(.custom("DS-Digital", size: 110)).fixedSize()
                    
                // When timer is running, every second runs this code
                    .onReceive(timer) { _ in
                
                        if self.time > 0 {
                            self.time -= 1
                            self.timeStringDisplay = self.integerToString(number: self.time)
                        } else if self.rest > 0 {
                            self.rest -= 1
                            self.restStringDisplay = self.integerToString(number: self.rest)
                        } else if self.round > 1 {
                            self.round -= 1
                            self.time = 10
                            self.rest = 5
                            self.timeStringDisplay = self.integerToString(number: self.time)
                            self.restStringDisplay = self.integerToString(number: self.rest)
                        } else {
                            self.buttonTitle = "ENGAGE"
                            self.timerIsRunning = false
                            self.timer.connect().cancel()
                        }
                        
                    }
            }
            
        // Rest Stack
        // ==========
            VStack {
                Text("REST")
                    .font(.subheadline).fixedSize()
                
                // Rest Remaining
                Text("\(self.restStringDisplay)").font(.custom("DS-Digital", size: 110)).fixedSize()
            }.padding(.top)
            
            
        // Random Noise Choice & Count
        // ===========================
            HStack {
                Text("\(self.noise)")
                    .font(.largeTitle).bold()
                    .fixedSize()
                Text("\(self.noiseTotal)")
                    .font(.largeTitle)
            }.padding()
            
        // Button Action & Design
        // ======================
            VStack {
                // Engage Button
                Button(action: {
                    self.timer.connect()
                    self.timerIsRunning = true
                    self.buttonTitle = "STOP"
                   
                }) { Text("\(self.buttonTitle)").font(.largeTitle)
                }
                    .font(.title)
                    .frame(width: 150)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .foregroundColor(.black)
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.black, lineWidth: 2)
                )
            }.padding()
        } //Main VStack Closure
    } // View Closure

// =====================================================================
// Methods
// =======
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
            var minutesToSeconds = minutes * 60
            var answer = minutesToSeconds + seconds
            return answer
        }
        return 0
    }

// =====================================================================
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
