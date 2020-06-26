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
    
    @State var onColor = Color(UIColor.systemBlue)
    @State var offColor = Color(UIColor.systemGray)
    @State var thumbColor = Color.white
    
    // Variables that help control the flow of the app, changing screens or releasing to the main screen
    @State var showingVariableCountExplanationView = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
    NavigationView {
            
        VStack {
            Form {
                
                Section {
                  HStack {
                    Text("Rounds").bold()
                        Spacer()
                        Text("\(self.engageTimer.totalRounds)")
                        Stepper("\(self.engageTimer.totalRounds)", value: $engageTimer.totalRounds, in: 0...25).labelsHidden()
                    }.padding()
                    
                    HStack {
                    Text("Time").bold()
                    Spacer()
                        Text(String(format: "%01i:%02i", self.engageTimer.time / 60, self.engageTimer.time % 60))
                        Stepper("", value: $engageTimer.time, in: 10...1200, step: 10).labelsHidden()

                    }.padding()
                    
                    HStack {
                    Text("Rest").bold()
                    Spacer()
                        Text(String(format: "%01i:%02i", self.engageTimer.rest / 60, self.engageTimer.rest % 60))
                        Stepper("", value: $engageTimer.rest, in: 0...639, step: 5).labelsHidden()
                        }.padding()
                }

                
               Section {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Engage Timer Cues").bold()
                        if engageTimer.usingRandomNoise {
                            Text("FX between \(self.engageTimer.lowerRange) and \(self.engageTimer.upperRange)")
                            Text("\(engageTimer.randomCount) engage cue total")
                        }
                    }
                    
                    Spacer()
                    RoundedRectangle(cornerRadius: 25, style: .circular)
                        .fill(engageTimer.usingRandomNoise ? onColor : offColor)
                        .frame(width: 75, height: 35)
                    .overlay(
                        Circle()
                        .fill(thumbColor)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(1.5)
                            .offset(x: engageTimer.usingRandomNoise ? 20 : -20)
                            .animation(Animation.easeInOut(duration: 0.3))
                            .onTapGesture { self.engageTimer.usingRandomNoise.toggle() }
                    )
                }.padding()
                
               if engageTimer.usingRandomNoise {
                    VStack {
                        HStack{
                            Text("Lower range: \(self.engageTimer.lowerRange) Seconds")
                            Spacer()
                            Stepper("", value: $engageTimer.lowerRange, in: 1...120, step: 1).labelsHidden()
                        }
                        HStack {
                            Text("Upper range: \(self.engageTimer.upperRange) Seconds")
                            Spacer()
                            Stepper("", value: $engageTimer.upperRange, in: 1...120, step: 1).labelsHidden()
                        }
                        }.padding()
                       }
                
                      if engageTimer.usingRandomNoise {
                       HStack {
                       
                              Picker(selection: $engageTimer.noiseChoice, label: Text("Choose Sound Effect").bold()) {
                                  
                                  ForEach (0 ..< engageTimer.noiseArray.count) {
                                      Text(self.engageTimer.noiseArray[$0])
                                  }
                              }
                            }.padding()
                          }
                }
                
                
                

                
                HStack {
                    Text("Get Ready Timer").bold()
                    Spacer()
                    RoundedRectangle(cornerRadius: 25, style: .circular)
                        .fill(engageTimer.usingPrepCountDown ? onColor : offColor)
                        .frame(width: 75, height: 35)
                    .overlay(
                        Circle()
                        .fill(thumbColor)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(1.5)
                            .offset(x: engageTimer.usingPrepCountDown ? 20 : -20)
                            .animation(Animation.easeInOut(duration: 0.3))
                            .onTapGesture { self.engageTimer.usingPrepCountDown.toggle() }
                    )
                }.padding()
                
                if engageTimer.usingPrepCountDown {
                    HStack{
                        Text("Prep Time").bold()
                        Spacer()
                        Text(String(format: "%01i:%02i", self.engageTimer.prepCountDown / 60, self.engageTimer.prepCountDown % 60))
                        Stepper("", value: $engageTimer.prepCountDown, in: 0...10, step: 1).labelsHidden()
                    }.padding()
                } else {
                    EmptyView()
                }
//
//
       
            
            } // Form Closure
          Button(action: {
                  self.presentationMode.wrappedValue.dismiss()
              }) {
                  Text("Swipe Down To Save")
              }.padding()
          } // Nav CLosure
              .navigationBarTitle("Edit Options")
              .sheet(isPresented: $showingVariableCountExplanationView) {
                  VariableCountExplanationView()
              }
        } // Main VStack Closure
        
        .onDisappear() {
            // Create random number array
            self.engageTimer.createRandomNumberArray()
            print(self.engageTimer.randomArray)
            // Capture reset values if timer is starting
            self.engageTimer.fillResetValues()
        }        
    
} // View Closure
    
 

struct EditEngageTimerOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        EditEngageTimerOptionsView().environmentObject(EngageTimer())
    }
}
}
