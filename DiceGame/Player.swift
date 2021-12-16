//
//  Player.swift
//  DiceGame
//
//  Created by Toni Löf on 2021-12-16.
//

import Foundation

class Player {
    
    let id: Int
   // var sum: Int
    var totalSum: Int
    var rounds: Int
    var wins : Int
    
    init(id: Int, totalSum: Int = 0, rounds: Int = 0, wins: Int = 0) {
        self.id = id
     //   self.sum = sum
        self.totalSum = totalSum
        self.rounds = rounds
        self.wins = wins
        
    }
    
}
