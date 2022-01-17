//
//  twoPlayerViewModel.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/15/22.
//

import Foundation
import SwiftUI

final class twoPlayerViewModel: ObservableObject  {
    let columns: [GridItem]  = [GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())]
    @Published var human1turn = true
    @Published var playersMoves: [playersMove?] = Array(repeating: nil, count: 9)
    @Published var playersAlertItem: AlertItem?
    @Published var playersScores = playersScoreboard()
    
    func isOccupied(in moves: [playersMove?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.playersboardIndex == index})
    }
    
    func checkWin(for player: players, in playersMove: [playersMove?]) -> Bool {
        let winPattern: Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        let player1Moves = playersMove.compactMap{ $0 }.filter{ $0.player == player }
        let player1Positions = Set(player1Moves.map{ $0.playersboardIndex})
        for pattern in winPattern where pattern.isSubset(of: player1Positions){
            return true
        }
        return false
    }
    
    
    func processClickHuman1(for position: Int) {
        if isOccupied(in: playersMoves, forIndex: position) {return}
        
        playersMoves[position] = playersMove(player: .human1, playersboardIndex: position)
        
        
        if checkWin(for: .human1, in: playersMoves) {
            playersAlertItem = AlertContext.human1Win
            playersScores.player1Win()
            return
        }
        if checkDraw( in: playersMoves) {
            playersAlertItem = AlertContext.draw
            return
        }
    }
    
    func processClickHuman2(for position: Int) {
        
        if isOccupied(in: playersMoves, forIndex: position) {return}
        
        playersMoves[position] = playersMove(player: .human2, playersboardIndex: position)
        
        
        if checkWin(for: .human2, in: playersMoves) {
            playersAlertItem = AlertContext.human2Win
            playersScores.player2Win()
            return
        }
        if checkDraw( in: playersMoves) {
            playersAlertItem = AlertContext.draw
            return
        }
    }
    
    func checkDraw(in playersMoves: [playersMove?]) -> Bool {
        return playersMoves.compactMap{ $0}.count == 9
    }
    
    func reset() {
        playersMoves = Array(repeating: nil, count: 9)
        human1turn = true
    }
    
}
