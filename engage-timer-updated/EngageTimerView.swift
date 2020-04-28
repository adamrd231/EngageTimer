//
//  ContentView.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 2/6/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import SwiftUI

struct EngageTimerView: View {
    
    // Notes
    // Fix time and rest reset in between rounds, state variable to track times?
    // find a way to get the layout to fill the whole screen?
    // Add start / stop noise into the app
    // Pause button?
    
    
    //Properties
    // =========
    @EnvironmentObject var engageTimer: EngageTimer
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State var editEngageTimerViewIsVisible = false
    @State var textSize = CGFloat(70)
    
    
    // ================================================================
    
    // User Interface Views
    var body: some View {
        NavigationView {
        Form {

            // Rounds Stack
            // =============================
                HStack {
                    Text("Round").font(.largeTitle)
                    Spacer()
                    Text("\(self.engageTimer.round)").font(.custom("DS-Digital", size: textSize))
            }
                    
            // Time Remaining Stack
            // ====================
                HStack {
                    Text("Time").font(.largeTitle)
                    Spacer()
                    Text("\(self.engageTimer.timeStringDisplay)").font(.custom("DS-Digital", size: textSize))
                    // When timer is running, every second runs this code
                        .onReceive(timer) { _ in
                            print("running timer")
                            self.runEngageTimer()
                        }
                }
                    
            // Rest Stack
            // ==========
               HStack {
                   Text("Rest").font(.largeTitle)
                    Spacer()
                   Text("\(self.engageTimer.restStringDisplay)").font(.custom("DS-Digital", size: textSize))
               }
       
   
           // Random Noise Choice & Count
           // ===========================
               HStack {
                   Text("\(self.engageTimer.noise)").font(.largeTitle).bold()
                    Spacer()
                    Text("\(self.engageTimer.noiseTotal)").font(.custom("DS-Digital", size: textSize))
               }
                    
            // Button Action & Design
            // ======================
            VStack (alignment: .center) {
                    Button(action: {
                        
                        if self.engageTimer.timerIsRunning == true {
                            self.cancelTimer()
                        } else {
                            self.instanstiateTimer()
                            self.timer.connect()
                            print("pressed print button")
                            self.engageTimer.timerIsRunning = true
                            self.engageTimer.buttonTitle = "STOP"
                        }
                        
                        
                    }) { Text("\(self.engageTimer.buttonTitle)")
                        .font(.largeTitle)
                    }
                        .font(.title)
                        .frame(width: 300)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .padding(5)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                    )
            }
            
            // Navigation Bar Layout and Design
        }
        .navigationBarTitle("Engage Timer", displayMode: .large)
        .navigationBarItems(trailing: Button("Edit") {
        self.engageTimer.buttonTitle = "ENGAGE"
        self.cancelTimer()
        self.editEngageTimerViewIsVisible = true
        print("Button Pressed")
                
            } )
        }.sheet(isPresented: $editEngageTimerViewIsVisible){
            EditEngageTimerOptionsView().environmentObject(self.engageTimer)
        }
        
        
} // View Closure


// Methods
// =======
func runEngageTimer() {
    if self.engageTimer.time > 0 {
        self.engageTimer.time -= 1
        self.engageTimer.timeStringDisplay = self.engageTimer.integerToString(number: self.engageTimer.time)
        
    } else if self.engageTimer.rest > 0 {
        self.engageTimer.rest -= 1
        self.engageTimer.restStringDisplay = self.engageTimer.integerToString(number: self.engageTimer.rest)
        
    } else if self.engageTimer.round > 1 {
        self.engageTimer.round -= 1
        // Update the reset to use the users input numbers
        // FIX FIX FIX
        self.engageTimer.time = 10
        self.engageTimer.rest = 5
        self.engageTimer.timeStringDisplay = self.engageTimer.integerToString(number: self.engageTimer.time)
        self.engageTimer.restStringDisplay = self.engageTimer.integerToString(number: self.engageTimer.rest)
        
    } else {
        self.cancelTimer()
    }
}
    

    
    func instanstiateTimer() {
        self.engageTimer.timerIsRunning = true
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
        return
    }
    
    func cancelTimer() {
        self.timer.connect().cancel()
        self.engageTimer.buttonTitle = "ENGAGE"
        self.engageTimer.timerIsRunning = false
    }


// =====================================================================
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EngageTimerView().environmentObject(EngageTimer())
    }
}
}
