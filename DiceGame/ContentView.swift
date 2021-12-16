//
//  ContentView.swift
//  DiceGame
//
//  Created by Toni Löf on 2021-12-16.
//

import SwiftUI

struct ContentView: View {
    @State var diceNr1 = 6
    @State var diceNr2 = 6
    @State var currentSum = 0
    @State var showingBustSheet = false
    @State var showing100Sheet = false
    @State var feftotalSum = 0
    @State var rounds = 0
    @State var playerSums: [Int] = [0, 0, 0]
    @State var currentPlayer = 0
    
    
    
    var body: some View {
        
        ZStack {
            Color(red: 71/256, green: 110/256, blue: 99/256).ignoresSafeArea()
            
            VStack {
                Text("Player: \(currentPlayer)Sum:\(currentSum)")
                    .font(.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
                Spacer()
                HStack {
                    
                    DiceView(n: diceNr1)
                    DiceView(n: diceNr2)
                    
                    
                }
            
                Spacer()
                Button(action: {stop()}) {
                    Text("Stop")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding(.horizontal)
                }
                .background(Color.red)
                .cornerRadius(15.0)
                Spacer()
                Button(action: {roll()}) {
                    Text("Roll")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding(.horizontal)
                }
                .background(Color.green)
                .cornerRadius(15.0)
                Spacer()
                Text("Total sum:\(playerSums[currentPlayer]) Nr of rounds: \(rounds)")
                
            }
            
        }
        .sheet(isPresented: $showingBustSheet, onDismiss: { currentSum = 0}) {
            BustSheet(sum: currentSum)
        }
        .sheet(isPresented: $showing100Sheet, onDismiss:{resetGame()}) {
            FinalSheet(finalSum: playerSums[currentPlayer], rounds: rounds, isPresented: $showing100Sheet)
        }
    }
    
    func roll() {
        diceNr1 = Int.random(in: 1...6)
        diceNr2 = Int.random(in: 1...6)
        currentSum += diceNr1 + diceNr2
        
        if currentSum > 21 {
            showingBustSheet = true
           
            if currentPlayer == playerSums.count - 1 {
               
                rounds += 1
                currentPlayer = 0
            }else{
                currentPlayer += 1
            }
           
        }
    }
    
    func stop() {
        playerSums[currentPlayer] += currentSum
        
        if playerSums[currentPlayer] >= 50 {
        showing100Sheet = true
            
        }else if currentPlayer == playerSums.count - 1 {
            
           currentPlayer = 0
            rounds += 1
        }else{
            currentPlayer += 1
        }
        
        currentSum = 0
        
        
    }
    
    func resetGame() {
        currentSum = 0
        playerSums[currentPlayer] = 0
        rounds = 0
        currentPlayer = 0
        
        
    }
}

struct FinalSheet: View {
    
    let finalSum: Int
    let rounds: Int
    @Binding var isPresented: Bool
    
    var body: some View {
        
        ZStack {
            Color(red: 71/256, green: 110/256, blue: 99/256).ignoresSafeArea()
            VStack {
                Spacer()
                Text("Good job!")
                    .font(.largeTitle)
                    .foregroundColor(Color.purple)
                    .padding()
                Text("You reached \(finalSum) in \(rounds) rounds. ")
                    .foregroundColor(Color.white)
                Spacer()
                Button(action: {isPresented = false}) {
                    Text("Play again")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .padding()
                }
            }
        }
    }
    
}



struct BustSheet: View {
    let sum: Int
    
    var body: some View {
        ZStack {
            Color(red: 71/256, green: 110/256, blue: 99/256).ignoresSafeArea()
            VStack {
                
                Text("Bust!")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                
                Text("\(sum)")
                    .foregroundColor(.red)
                    .font(.title)
                    .padding()
                
            }
            
        }
    }
    
}


struct DiceView: View {
    let n: Int // Kan sätta default med =
    
    var body: some View {
        
        Image(systemName: "die.face.\(n)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
        
    }
    
}

struct StartView: View {
 
    @State private var username: String = ""
    
    var body: some View {
        
        ZStack {
            Color(red: 71/256, green: 110/256, blue: 99/256).ignoresSafeArea()
            
            VStack {
                Text("How many people are playing?")
                    .font(.title2)
                    .foregroundColor(Color.white)
                Text("(Max 10 players)")
                    .foregroundColor(Color.white)
                TextField("Username", text: $username)
                Spacer()

            }
            .padding()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
       // StartView()
        //        BustSheet(sum: 27)
                ContentView()
      //  FinalSheet(finalSum: 100, rounds: 5, isPresented: )
    }
}
