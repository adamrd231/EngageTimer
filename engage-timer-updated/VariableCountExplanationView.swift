//
//  VariableCountExplanationView.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 5/20/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import SwiftUI

struct VariableCountExplanationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            
            Color(.systemGray6).edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .center){
                Text("Random Count Spacing").font(.title).bold()
                Text("This variable counter is used to adjust the amount of space in between random counts. When adjusting the setting, you are controlling the minimum time that will be gauranteed between sounds. \n A one second minimum setting will alow for more counts than a three or seven second minimum settings.").fixedSize(horizontal: false, vertical: true).padding()
                
                }.padding()
                
                VStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Swipe Down To Save").bold()
                    }.padding()
                }
            }
            
            
        }
        
        
    }
}

struct VariableCountExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        VariableCountExplanationView()
    }
}
