//
//  VariableCountExplanationView.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 5/20/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import SwiftUI

struct VariableCountExplanationView: View {
    var body: some View {
        VStack(alignment: .center){
            Text("Random Count Spacing").font(.title).bold()
            Text("This variable counter is used to adjust the amount of space in between random counts. When adjusting the setting, the random count will automatically be reduced to accomodate the larger gaps in time, 1 second between counts allows for a lot more random counts then 3 or 7 seconds.").fixedSize(horizontal: false, vertical: true).padding()
            Text("Swipe Down To Close").bold()
            }.padding()
        
    }
}

struct VariableCountExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        VariableCountExplanationView()
    }
}
