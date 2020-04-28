//  Created by Adam Reed on 2/6/20.
//  Copyright © 2020 rdConcepts. All rights reserved.

// Notes
// find a way to get the layout to fill the whole screen?
// Add start / stop noise into the app
// Add random noises to app
// Add in random noise algorithm

import SwiftUI

struct EngageTimerView: View {
    
    //Properties
    // =========
    @EnvironmentObject var engageTimer: EngageTimer
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
    
    // Reset values used only for this View
    @State var pauseButtonTitle = "Pause"
    @State var timeReset = 0
    @State var restReset = 0
    @State var roundReset = 0
    @State var noiseCountReset = 0
    
    // State variable to bring up editing view
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
                        self.resetValues()
                        self.engageTimer.buttonTitle = "Engage"
                    } else if self.pauseButtonTitle == "Re-start" {
                        self.cancelTimer()
                        self.resetValues()
                        self.engageTimer.buttonTitle = "Engage"
                        self.pauseButtonTitle = "Pause"
                    } else {
                        // Capture reset values if timer is starting
                        self.fillResetValues()
                        self.instanstiateTimer()
                        self.timer.connect()
                        playSound(sound: "boxing-bell-1", type: "wav")
                        self.engageTimer.timerIsRunning = true
                        self.engageTimer.buttonTitle = "Stop"
                    }
                })
                { Text("\(self.engageTimer.buttonTitle)") }
                    .font(.title)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .padding(3)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
                )
            }
            
            VStack {
                Button(action: {
                              
                  if self.engageTimer.timerIsRunning == true {
                      //Pause the Timer
                    self.cancelTimer()
                    self.pauseButtonTitle = "Re-start"
                    
                  } else if self.engageTimer.buttonTitle == "Engage" {
                    return
                } else {
                      // Restart the Timer
                    self.instanstiateTimer()
                    self.timer.connect()
                    self.pauseButtonTitle = "Pause"
                  }
                }) { Text("\(self.pauseButtonTitle)") }
                      .font(.title)
                      .frame(minWidth: 0, maxWidth: .infinity)
                      .background(Color.white)
                      .foregroundColor(.black)
                      .padding(3)
                      .overlay(RoundedRectangle(cornerRadius: 10)
                      .stroke(Color.black, lineWidth: 2)
                  )
            } // VStack Close
            
        }// Form Close
         // Navigation Bar Layout and Design
        .navigationBarTitle("Engage Timer", displayMode: .large)
        .navigationBarItems(trailing: Button("Edit") {
            self.engageTimer.buttonTitle = "Engage"
            self.cancelTimer()
            self.editEngageTimerViewIsVisible = true
        })
    } // Navigation View Close
      // Present options sheet using binded variable and pass environment object
    .sheet(isPresented: $editEngageTimerViewIsVisible){ EditEngageTimerOptionsView().environmentObject(self.engageTimer) }
        
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
    
    func resetValues() {
        self.engageTimer.round = self.roundReset
        
        self.engageTimer.time = self.timeReset
        self.engageTimer.timeStringDisplay = self.engageTimer.integerToString(number: self.engageTimer.time)
        
        self.engageTimer.rest = self.restReset
        self.engageTimer.restStringDisplay = self.engageTimer.integerToString(number: self.engageTimer.rest)
        self.engageTimer.noiseTotal = self.noiseCountReset
    }

    func fillResetValues() {
        self.roundReset = self.engageTimer.round
        self.timeReset = self.engageTimer.time
        self.restReset = self.engageTimer.rest
        self.noiseCountReset = self.engageTimer.noiseTotal
    }
    
    func instanstiateTimer() {
        self.engageTimer.timerIsRunning = true
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
        return
    }
    
    func cancelTimer() {
        self.timer.connect().cancel()
        self.engageTimer.timerIsRunning = false
    }


// =====================================================================
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EngageTimerView().environmentObject(EngageTimer())
    }
}
}
