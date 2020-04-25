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
    @ObservedObject var engageTimer = EngageTimer()
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
    
    // ================================================================
    
    // User Interface Views
    var body: some View {
        NavigationView {
        Form {
            // Rounds Stack
            // =============================

                VStack {
                    Text("ROUND")
                        .font(.subheadline)
                    
                    // Rounds Remaining
                    Text("\(self.engageTimer.round)").font(.custom("DS-Digital", size: 80)).fixedSize()
                }
                    
            // Time Remaining Stack
            // ====================
                VStack {
                    // Time description
                    Text("TIME")
                        .font(.subheadline)

                    // Time Remaining
                    Text("\(self.engageTimer.timeStringDisplay)").font(.custom("DS-Digital", size: 110)).fixedSize()

                    // When timer is running, every second runs this code
                        .onReceive(timer) { _ in
                            print("running timer")
                            if self.engageTimer.time > 0 {
                                self.engageTimer.time -= 1
                                self.engageTimer.timeStringDisplay = self.integerToString(number: self.engageTimer.time)
                                print(self.engageTimer.timeStringDisplay)
                                
                            } else if self.engageTimer.rest > 0 {
                                self.engageTimer.rest -= 1
                                self.engageTimer.restStringDisplay = self.integerToString(number: self.engageTimer.rest)
                            } else if self.engageTimer.round > 1 {
                                self.engageTimer.round -= 1
                                self.engageTimer.time = 10
                                self.engageTimer.rest = 5
                                self.engageTimer.timeStringDisplay = self.integerToString(number: self.engageTimer.time)
                                self.engageTimer.restStringDisplay = self.integerToString(number: self.engageTimer.rest)
                            } else {
                                self.engageTimer.buttonTitle = "ENGAGE"
                                self.engageTimer.timerIsRunning = false
                                self.timer.connect().cancel()
                            }
                        }
                } // Close Time Remaining Stack
                    
            // Rest Stack
            // ==========
               VStack {
                   Text("REST")
                       .font(.subheadline).fixedSize()
   
                   // Rest Remaining
                   Text("\(self.engageTimer.restStringDisplay)").font(.custom("DS-Digital", size: 110)).fixedSize()
               }
       
   
           // Random Noise Choice & Count
           // ===========================
               HStack {
                   Text("\(self.engageTimer.noise)")
                       .font(.largeTitle).bold()
                       .fixedSize()
                   Text("\(self.engageTimer.noiseTotal)")
                       .font(.largeTitle)
               }.padding()
                    
            // Button Action & Design
            // ======================
                VStack {
                    // Engage Button
                    Button(action: {
                        self.timer.connect()
                        print("pressed print button")
                        self.engageTimer.timerIsRunning = true
                        self.engageTimer.buttonTitle = "STOP"

                    }) { Text("\(self.engageTimer.buttonTitle)").font(.largeTitle)
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
            }.navigationBarTitle("EngageTimer")
            .navigationBarItems(trailing: Button("Edit") { print("Button Pressed")} )
        }
} // View Closure

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
                let minutesToSeconds = minutes * 60
                let answer = minutesToSeconds + seconds
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
