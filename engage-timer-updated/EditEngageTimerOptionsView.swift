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
    
    var body: some View {
    NavigationView {
        VStack{
            Form {
                HStack {
                Text("Rounds")
                    Spacer()
                    Text("\(self.engageTimer.round)")
                    Stepper("\(self.engageTimer.round)", value: $engageTimer.round, in: 0...25).labelsHidden()
                }
                
                HStack {
                Text("Time")
                Spacer()
                    Text(String(format: "%01i:%02i", self.engageTimer.time / 60, self.engageTimer.time % 60))
                    Stepper("", value: $engageTimer.time, in: 10...639, step: 10).labelsHidden()
                    }
                
                HStack {
                Text("Rest")
                Spacer()
                    Text(String(format: "%01i:%02i", self.engageTimer.rest / 60, self.engageTimer.rest % 60))
                    Stepper("", value: $engageTimer.rest, in: 0...639, step: 5).labelsHidden()
                    }
                    
                HStack {
                Text("Noise Count")
                Spacer()
                    Text("\(self.engageTimer.noiseTotal)")
                    Stepper("", value: $engageTimer.noiseTotal, in: 0...engageTimer.time / 5).labelsHidden()
                    }
                

            .navigationBarTitle("Edit Options")

        }
        Text("Swipe Down To Save").padding()
            
        } // Form Closure
        } // Main VStack Closure
    } // Nav CLosure
} // View Closure
 

struct EditEngageTimerOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        EditEngageTimerOptionsView().environmentObject(EngageTimer())
    }
}
