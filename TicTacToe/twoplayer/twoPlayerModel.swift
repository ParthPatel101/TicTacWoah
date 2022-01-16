//
//  twoPlayerModel.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/15/22.
//

import Foundation
import SwiftUI

enum players {
    case human1, human2
}

struct playersScoreboard: Codable {
    var player1Score: Int = 0
    var player2Score: Int = 0
    
    mutating func player1Win() {
        self.player1Score += 1
    }
    
    mutating func player2Win() {
        self.player2Score += 1
    }
}

struct playersMove {
    let player: players
    let playersboardIndex: Int
    
    var indicator: String {
        return player == .human1 ? "xmark" : "circle"
    }
}
