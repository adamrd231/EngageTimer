//
//  EditEngageTimerOptionsView.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 4/26/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import SwiftUI

struct EditEngageTimerOptionsView: View {
    
    @State private var stepperVallue = 10
    
    var body: some View {
    VStack{
        Form {
            Section {
                HStack {
                Text("Rounds")
                 Spacer()
                 Text("2")
                 }
                 Stepper("", onIncrement: {
                     self.stepperVallue += 1
                 }, onDecrement: {
                     self.stepperVallue -= 1
                 })
            }
            
            Section {
                HStack {
                Text("Time")
                 Spacer()
                 Text("1:00")
                 }
                 Stepper("", onIncrement: {
                     self.stepperVallue += 1
                 }, onDecrement: {
                     self.stepperVallue -= 1
                 })
            }
            
            Section {
                HStack {
                Text("Rest")
                 Spacer()
                 Text("0:30")
                 }
                 Stepper("", onIncrement: {
                     self.stepperVallue += 1
                 }, onDecrement: {
                     self.stepperVallue -= 1
                 })
            }
            
            Section {
                HStack {
                Text("Random Noise")
                 Spacer()
                 Text("1")
                 }
                 Stepper("", onIncrement: {
                     self.stepperVallue += 1
                 }, onDecrement: {
                     self.stepperVallue -= 1
                 })
            }
            
  
            
        }
        Text("Swipe Down To Cancel").padding()
        }
    }
}

struct EditEngageTimerOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        EditEngageTimerOptionsView()
    }
}
