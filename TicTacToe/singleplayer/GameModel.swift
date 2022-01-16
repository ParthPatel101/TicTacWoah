//
//  GameModel.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/15/22.
//

import Foundation
import SwiftUI

enum Player {
    case human, computer
}
struct scoreboard: Codable {
    var playerScore: Int = 0
    var computerScore: Int = 0
    
    mutating func playerWin() {
        self.playerScore += 1
    }
    
    mutating func computerWin() {
        self.computerScore += 1
    }
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct GameCircleView: View {
    var proxy:  GeometryProxy
    var difficultyColor: Color
    var body: some View {
        if difficultyColor == Color.green {
            Circle()
                .frame(width: proxy.size.width/3 - 15, height: proxy .size.width/3 - 15)
                .foregroundColor(difficultyColor)
        }
        else if difficultyColor == Color.yellow {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .frame(width: proxy.size.width/3 - 15, height: proxy .size.width/3 - 15)
                .foregroundColor(difficultyColor)
        }
        else {
            Triangle()
                .frame(width: proxy.size.width/3 - 15, height: proxy .size.width/3 - 15)
                .foregroundColor(difficultyColor)
        }
    }
}

struct placeObject: View {
    var SystemImageName: String
    var body: some View {
        Image(systemName: SystemImageName)
            .resizable()
            .frame(width: 40, height: 40 )
            .foregroundColor(Color.white )
    }
}
