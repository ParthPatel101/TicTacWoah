//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/14/22.
//

import SwiftUI

final class GameViewModel: ObservableObject  {
    let columns: [GridItem]  = [GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())]
    
    @Published var gameStarted: Bool = false
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var wait: Bool = false
    @Published var alertItem: AlertItem?
    @Published var gameDifficulty: String = "trash"
    @Published var difficultyEmojis: [String] = ["trash","brain.head.profile", "exclamationmark.square.fill"]
    @Published var scores: scoreboard = scoreboard()
    
    func isOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index})
    }
    
    
    func findDifficultyColor() -> Color {
        if gameDifficulty == "trash" {
            return Color.green
        }
        else if gameDifficulty == "brain.head.profile" {
            return Color.yellow
        }
        else {
            return Color.red
            
        }
    }
    
    func findAIPosition(in moves: [Move?]) -> Int {
        
        //if AI can win, then win [HARD DIFFCULTY]
        let winPattern: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        if gameDifficulty == "exclamationmark.square.fill" {
            let AIMoves = moves.compactMap{ $0 }.filter{ $0.player == .computer}
            let AIPositions = Set( AIMoves.map{ $0.boardIndex})
            for pattern in winPattern {
                let winPositions = pattern.subtracting(AIPositions)
                if winPositions.count == 1 {
                    let isAvailable = !isOccupied(in: moves, forIndex: winPositions.first!)
                    if isAvailable {
                        return winPositions.first!
                    }
                }
            }
        }
        
        
        //if human can win, then block win [MEDIUM]
        if gameDifficulty == "exclamationmark.square.fill" || gameDifficulty == "brain.head.profile" {
            let humanMoves = moves.compactMap{ $0 }.filter{ $0.player == .human}
            let humanPosition = Set( humanMoves.map{ $0.boardIndex})
            for pattern in winPattern {
                let winPositions = pattern.subtracting(humanPosition)
                if winPositions.count == 1 {
                    let isAvailable = !isOccupied(in: moves, forIndex: winPositions.first!)
                    if isAvailable {
                        return winPositions.first!
                    }
                }
            }
            
            //if AI can't block, take middle
            let middle = 4
            if !isOccupied(in: moves, forIndex: middle) {
                return middle
            }
        }
        
        //else pick random [EASY]
        var movePosition = Int.random(in: 0..<9)
        while isOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
    
    func checkWin(for player: Player, in moves: [Move?]) -> Bool {
        let winPattern: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        let playerMoves = moves.compactMap{ $0 }.filter{ $0.player == player}
        let playerPositions = Set(playerMoves.map{ $0.boardIndex})
        for pattern in winPattern where pattern.isSubset(of: playerPositions){
            return true
        }
        return false
    }
    
    func checkDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap{ $0}.count == 9
    }
    
    func reset() {
        moves = Array(repeating: nil, count: 9)
        gameStarted = false
    }
    
    
    func processClick(for position:  Int) {
        //Human Move Processing
        if isOccupied(in: moves, forIndex: position) {return}
        
        moves[position] = Move(player: .human, boardIndex: position)
        
        
        if checkWin(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            scores.playerWin()
            return
        }
        if checkDraw( in: moves) {
            alertItem = AlertContext.draw
            return
        }
        wait = true
        
        //AI  Move Processing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPostion =  findAIPosition(in: moves)
            moves[computerPostion] = Move(player: .computer, boardIndex: computerPostion)
            wait = false
            if checkWin(for: .computer, in: moves) {
                alertItem = AlertContext.computerWin
                scores.computerWin()
                return
            }
            if checkDraw( in: moves) {
                alertItem = AlertContext.draw
                return
            }
        }
    }
    
    func disableDifficultyChanger() -> Bool{
        if wait {
            return true
        }
        return false
    }
    
    
}
