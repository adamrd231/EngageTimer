//
//  EngageButton.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 5/4/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import SwiftUI

struct EngageButton: View {
    
    @EnvironmentObject var engageTimer: EngageTimer
    
    
    var body: some View {
        Button(action: {
            EmptyView()
        })
        { Text("\(self.engageTimer.buttonTitle)") }
            .font(.title)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(10)
            .background(Capsule().stroke(lineWidth: 2))
            .foregroundColor(.black)
    }
}

struct EngageButton_Previews: PreviewProvider {
    static var previews: some View {
        EngageButton()
    }
}
