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
    @State var noiseSelection: String = "Test"
    
    var body: some View {
        
    NavigationView {
        VStack{
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
                    Stepper("", value: $engageTimer.time, in: 10...639, step: 10).labelsHidden()
                    }.padding()
                
                HStack {
                Text("Rest")
                Spacer()
                    Text(String(format: "%01i:%02i", self.engageTimer.rest / 60, self.engageTimer.rest % 60))
                    Stepper("", value: $engageTimer.rest, in: 0...639, step: 5).labelsHidden()
                    }.padding()
                    
                HStack {
                Text("Noise Count")
                Spacer()
                    Text("\(self.engageTimer.noiseTotal)")
                    Stepper("", value: $engageTimer.noiseTotal, in: 0...engageTimer.time / 5).labelsHidden()
                    }.padding()
                
                HStack {
                    Toggle(isOn: $engageTimer.usingRandomNoise) {
                                      Text("Random Sound Effect")
                                  }
                }.padding()
                
                HStack {
                    if engageTimer.usingRandomNoise {
                        Picker(selection: $engageTimer.noise, label: Text("Currently Using...")) {
                       ForEach(engageTimer.noiseArray, id: \.self) { noise in
                           Text("\(noise)")
                       }
                       }
                    }
                    }.padding()
                                  
                                  

              
                    
            .navigationBarTitle("Edit Options")
        }
        Text("Swipe Down To Save").padding()
            
        } // Form Closure
        } // Main VStack Closure
    } // Nav CLosure
} // View Closure

func makeRandomNumberArray(_ number: Int) -> [Int] {
    return (0..<number).map { _ in .random(in: 1...20) }
}
 

struct EditEngageTimerOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        EditEngageTimerOptionsView().environmentObject(EngageTimer())
    }
}
