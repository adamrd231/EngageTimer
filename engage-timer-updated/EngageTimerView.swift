//
//  ContentView.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 2/6/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import SwiftUI

struct EngageTimerView: View {
    
    //Properties
    // =========
    @EnvironmentObject var engageTimer: EngageTimer
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State var editEngageTimerViewIsVisible = false
    @State var textSize = CGFloat(80)
    
    
    // ================================================================
    
    // User Interface Views
    var body: some View {
        NavigationView {
        List {

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
                            self.updateTimerDisplay()
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
                            self.engageTimer.buttonTitle = "ENGAGE"
                            self.engageTimer.timerIsRunning = false
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
                        .cornerRadius(25)
                        .foregroundColor(.black)
                        .padding(5)
                        .overlay(RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.black, lineWidth: 2)
                    )
                }
            
            // Navigation Bar Layout and Design
        }
        .navigationBarTitle("EngageTimer", displayMode: .inline)
        .navigationBarItems(trailing: Button("Edit") {
        self.editEngageTimerViewIsVisible = true
        print("Button Pressed")
                
            } )
        }.sheet(isPresented: $editEngageTimerViewIsVisible){
            EditEngageTimerOptionsView()
        }
        
        
} // View Closure


// Methods
// =======
func updateTimerDisplay() {
    if self.engageTimer.time > 0 {
        self.engageTimer.time -= 1
        self.engageTimer.timeStringDisplay = self.engageTimer.integerToString(number: self.engageTimer.time)
        print(self.engageTimer.timeStringDisplay)
        
    } else if self.engageTimer.rest > 0 {
        self.engageTimer.rest -= 1
        self.engageTimer.restStringDisplay = self.engageTimer.integerToString(number: self.engageTimer.rest)
    } else if self.engageTimer.round > 1 {
        self.engageTimer.round -= 1
        self.engageTimer.time = 10
        self.engageTimer.rest = 5
        self.engageTimer.timeStringDisplay = self.engageTimer.integerToString(number: self.engageTimer.time)
        self.engageTimer.restStringDisplay = self.engageTimer.integerToString(number: self.engageTimer.rest)
    } else {
        self.engageTimer.buttonTitle = "ENGAGE"
        self.engageTimer.timerIsRunning = false
        self.timer.connect().cancel()
    }
}
    
    func instanstiateTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
        return
    }
    
    func cancelTimer() {
        self.timer.connect().cancel()
    }


// =====================================================================
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EngageTimerView().environmentObject(EngageTimer())
    }
}
}
