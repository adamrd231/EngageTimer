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
        GeometryReader { geo in
            VStack {
                Image("engage-icon-transparent")
                    .resizable()
                    .scaledToFit()
                    .frame(height: geo.size.height / 4)
                Text("The Engage Timer.")
                    .font(.title)
                Text("The Engage Timer was developed to help bring a true random element into our fitness routines. Developing reflexes and fast twitch muscles comes from reacting to something that you can plan on. I hope you enjoy this timer. \n\nQuestions: contact@rdConcepts.design")
                    .font(.body).padding()
                    .frame(width: geo.size.width * 0.9)
                Text("Swipe Down To Return").padding().font(.subheadline)
            }
        }
    }
}

struct ExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        ExplanationView().colorScheme(.dark)
    }
}
