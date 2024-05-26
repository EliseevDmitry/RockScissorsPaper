//
//  ContentView.swift
//  RockScissorsPaper
//
//  Created by Dmitriy Eliseev on 26.05.2024.
//

import SwiftUI

struct gameImage: View {
    //MARK: - PROPORTIES
    var image: String
    //MARK: - BODY
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .padding(3)
            .background(.white)
            .padding(3)
            .background(.blue)
    }
}

struct ContentView: View {
    
    //MARK: - PROPORTIES
    let arrayQuestions = ["paper", "rock", "scissors"]
    let arrayAnswer = ["scissors", "paper", "rock"]
    @State private var randomIndex: Int = Int.random(in: 0...2)
    @State private var isVisibleQuestions = false
    @State private var showingScore: Bool = false
    @State private var score = 0
    @State private var showingCountQuestion: Bool = false
    @State private var countQuestion = 0
    
    //MARK: - BODY
    var body: some View {
        Spacer()
        Text("Rock - Scissors - Paper")
            .font(.title)
        Spacer()
        gameImage(image: arrayQuestions[randomIndex])
            .opacity(isVisibleQuestions ? 1 : 0)
            .background(isVisibleQuestions ? .clear : .red)
        HStack {
            ForEach(0..<3){index in
                Button{
                    objectSelection(index)
                } label: {
                    gameImage(image: arrayAnswer[index])
                }
                .alert("Good", isPresented: $showingScore) {
                    Button("Continue", action: newGame)
                } message: {
                    Text("Your score is \(score)")
                }
                .alert("Ten questions complite.", isPresented: $showingCountQuestion) {
                    Button("Delite score and try again?", action: resetGame)
                } message: {
                    Text("Your score is \(score)")
                }
            }//: ForEach
        }//: HSTACK
        .padding()
        Spacer()
        Text("Your score is \(score)")
            .font(.headline)
        Spacer()
    }
    
    func objectSelection(_ number: Int){
        countQuestion += 1
        if countQuestion == 10 {
            showingCountQuestion = true
            return
        } else {
            if number == randomIndex {
                score += 1
                isVisibleQuestions = true
                showingScore = true
            } else {
                if score > 0 {
                    score -= 1
                }
                newGame()
            }
        }
    }
    
    func newGame(){
        randomIndex = Int.random(in: 0...2)
        isVisibleQuestions = false
    }
    
    func resetGame(){
        score = 0
        countQuestion = 0
        showingCountQuestion = false
        newGame()
    }
}

//MARK: - PREVIEW
#Preview {
    ContentView()
}
