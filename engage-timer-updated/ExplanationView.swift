//
//  ExplanationView.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 5/7/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import SwiftUI

struct ExplanationView: View {
    var body: some View {
        VStack {
            Image("engage-icon").resizable().scaledToFit()
            Text("The Engage Timer.").font(.title)
            Text("Designed to simulate having a trainer with you at home, use our timer to incororate extra focus and engagement into your workout. Use the timer on a run and sprint on the random noise, while shadow boxing anytime the random noise goes off you can simulate the opponent striking. \n\nQuestions: contact@rdConcepts.design").padding()
            Text("Swipe Down To Return").padding().font(.subheadline)
        }.padding()
    }
}

struct ExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        ExplanationView()
    }
}
