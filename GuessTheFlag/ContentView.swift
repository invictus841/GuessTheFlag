//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alexandre Talatinian on 27/05/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0

    @State private var numberOfQuestions = 1
    
    @State private var showingFinalScore = false
    @State private var finalScoreTitle = ""
    
    @State private var countries = allCountries.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    
    
    // MARK: - BODY
    var body: some View {
        
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    } //: VSTACK
                    
                    ForEach(0..<3) { number in
                                Button {
                                    flagTapped(number)
                                } label: {
                                    Image(countries[number])
                                        .renderingMode(.original)
                                        .clipShape(Capsule())
                                        .shadow(radius: 5)
                        }
                    }
                } //: VSTACK
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Text("Question n°\(numberOfQuestions)")
                    .foregroundStyle(.secondary)
                    .font(.headline.weight(.bold))
                
                Spacer()
            } //: VSTACK
            .padding()
        } //: ZSTACK
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(finalScoreTitle, isPresented: $showingFinalScore) {
            Button("Play Again", action: resetGame)
        } message: {
            Text("\(score)")
                .font(.largeTitle)
        }
    }
    
    func flagTapped(_ number: Int) {
            
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            
        } else {
            let needsThe = ["UK", "US"]
            let theirAnswer = countries[number]
            
            if needsThe.contains(theirAnswer) {
                scoreTitle = "Wrong! That's the flag of the \(countries[number])!"
            } else {
                scoreTitle = "Wrong! That's the flag of \(countries[number])!"
            }
            
            score -= 1
            
        }
        
        if numberOfQuestions == 3 {
            finalScoreTitle = "Your final result:"
            showingFinalScore = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.remove(at: correctAnswer)
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        numberOfQuestions += 1
    }
    
    func resetGame() {
        numberOfQuestions = 1
        score = 0
        countries = ContentView.allCountries
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
