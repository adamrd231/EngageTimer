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
                
                HStack {
                    if engageTimer.usingPrepCountDown {
                        Text("Prep Time").bold()
                        Spacer()
                            Text(String(format: "%01i:%02i", self.engageTimer.prepCountDown / 60, self.engageTimer.prepCountDown % 60))
                        Stepper("", value: $engageTimer.prepCountDown, in: 0...10, step: 1).labelsHidden()
                    }
                
                    }.padding()
                
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
              
                
                
                
                HStack {
                    
                    Text("Random Effect").bold()
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
                
                HStack {
                if engageTimer.usingRandomNoise {
                    Text("Noise Count").bold()
                    Spacer()
                        Text("\(self.engageTimer.noiseTotal)")
                    Stepper("", value: $engageTimer.noiseTotal, in: 1...engageTimer.time).labelsHidden()
                  
                       
                    }
                }.padding()
                
                HStack {
                if engageTimer.usingRandomNoise {
                       Picker(selection: $engageTimer.noiseChoice, label: Text("Sound Effect").bold()) {
                           
                           ForEach (0 ..< engageTimer.noiseArray.count) {
                               Text(self.engageTimer.noiseArray[$0])
                           }
                       }
                     }
                   }.padding()
                
                VStack() {
                   
                   if engageTimer.usingRandomNoise {
                    HStack {
                        
                        Slider(value: $engageTimer.randomCountSpeed, in: 1...3, step: 1.0)
                        
                        Button(action: {
                            self.showingVariableCountExplanationView = true
                            print("Pressed Info Button")
                        }) {
                            Image(systemName: "questionmark.circle")
                        }.padding(.leading)
                    }
                    
                    HStack {
                        if self.engageTimer.randomCountSpeed == 1.0 {
                            Text("Min 1 second between counts")
                        } else if self.engageTimer.randomCountSpeed == 2.0 {
                            Text("Min 3 seconds between counts")
                        } else {
                            Text("Min 7 seconds between counts")
                        }
                       
                    }.padding(.bottom)
                    }
                }.padding()
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
        // Text("Swipe Down To Save").padding()
        
    
} // View Closure
    
 

struct EditEngageTimerOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        EditEngageTimerOptionsView().environmentObject(EngageTimer())
    }
}
}
