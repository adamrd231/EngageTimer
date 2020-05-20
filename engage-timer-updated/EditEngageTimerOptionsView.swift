//
//  EditEngageTimerOptionsView.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 4/26/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import SwiftUI

struct EditEngageTimerOptionsView: View {
    
    @EnvironmentObject var engageTimer: EngageTimer
    @State var round = 1
    @State var randomSpeed = 1.0
    
    var body: some View {
        
    NavigationView {
        VStack {
            Form {
                
                HStack {
                Text("Rounds")
                    Spacer()
                    Text("\(self.engageTimer.totalRounds)")
                    Stepper("\(self.engageTimer.totalRounds)", value: $engageTimer.totalRounds, in: 0...25).labelsHidden()
                }.padding()
                
                HStack {
                Text("Time")
                Spacer()
                    Text(String(format: "%01i:%02i", self.engageTimer.time / 60, self.engageTimer.time % 60))
                    
                    Stepper("\(engageTimer.time)", onIncrement: {
                        self.engageTimer.time += 10
                    }, onDecrement: {
                        if self.engageTimer.time == 0 {
                            self.engageTimer.time += 10
                        } else {
                            self.engageTimer.time -= 10
                        }

                        if self.engageTimer.time / 5 < self.engageTimer.noiseTotal {
                            self.engageTimer.noiseTotal = self.engageTimer.time / 5
                        }
                        }).labelsHidden()

                }.padding()
                
                HStack {
                Text("Rest")
                Spacer()
                    Text(String(format: "%01i:%02i", self.engageTimer.rest / 60, self.engageTimer.rest % 60))
                    Stepper("", value: $engageTimer.rest, in: 0...639, step: 5).labelsHidden()
                    }.padding()
                    
                HStack {
                    Toggle(isOn: $engageTimer.usingRandomNoise) {
                                      Text("Random Effect")
                                  }
                }.padding()
                
                HStack {
                if engageTimer.usingRandomNoise {
                    Text("Noise Count")
                    Spacer()
                        Text("\(self.engageTimer.noiseTotal)")
                        Stepper("", value: $engageTimer.noiseTotal, in: 0...engageTimer.time / 5).labelsHidden()
                    }
                }.padding()
                
                HStack {
                if engageTimer.usingRandomNoise {
                       Picker(selection: $engageTimer.noiseChoice, label: Text("Sound Effect")) {
                           
                           ForEach (0 ..< engageTimer.noiseArray.count) {
                               Text(self.engageTimer.noiseArray[$0])
                           }
                       }
                     }
                   }.padding()
                    
                HStack {
                    Text("\(self.randomSpeed) seconds in between random count. ")
                    Slider(value: $randomSpeed, in: 0...5, step: 1.0)
                }.padding()
//
//
//        Text("Swipe Down To Save").padding()
            
        } // Form Closure
            
        } // Main VStack Closure
        .navigationBarTitle("Edit Options")
    } // Nav CLosure
} // View Closure

 

struct EditEngageTimerOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        EditEngageTimerOptionsView().environmentObject(EngageTimer())
    }
}
}
