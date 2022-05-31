//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alexandre Talatinian on 27/05/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var correctAnswer = Int.random(in: 0...2)
    
    // MARK: - BODY
    var body: some View {
        
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                } //: VSTACK
                
                ForEach(0..<3) { number in
                            Button {
                                // flag was tapped
                            } label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                    }
                }
            }
        } //: VSTACK
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
