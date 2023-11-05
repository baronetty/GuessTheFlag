//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Leo  on 03.11.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var wrongAnswer = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var endOfGame = false
    @State private var rounds = 0
    
    @State private var score = 0
    
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
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        
        .alert("End of Game", isPresented: $endOfGame) {
            Button("Repeat", action: repeatGame)
        } message: {
            Text("""
                Your Score: \(score)
                Want to start a new game?
                """)
        }
        
        
        
        
    }
    
    
    func flagTapped (_ number: Int) {
        
        let selectedCountry = countries[number]
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            rounds += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(selectedCountry)"
            rounds += 1
        }
        
        
        if rounds == 3 {
            endOfGame = true
            rounds = 0
        }
        
        showingScore = true
    }
    
    
    func askQuestion () {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func repeatGame() {
        askQuestion()
        score = 0
    }
    
    
}

#Preview {
    ContentView()
}
