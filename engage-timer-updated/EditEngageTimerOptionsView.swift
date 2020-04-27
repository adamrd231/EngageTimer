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
                 }
                 Stepper("", onIncrement: {
                    self.engageTimer.round += 1
                 }, onDecrement: {
                    self.engageTimer.round -= 1
                 })

            .navigationBarTitle("Edit Options")

        }
        Text("Swipe Down To Cancel").padding()
        } // Form Closure
        } // Main VStack Closure
    } // Nav CLosure
} // View Closure

struct EditEngageTimerOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        EditEngageTimerOptionsView().environmentObject(EngageTimer())
    }
}
