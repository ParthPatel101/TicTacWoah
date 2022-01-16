//
//     Alerts.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/14/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You Win"), message: Text("you are so smart!"), buttonTitle: Text("Hell Yeah!"))
    static let computerWin = AlertItem(title: Text("You Lose"), message: Text("ah ah ah, you didn't say the magic word!"), buttonTitle: Text("Try Again!"))
    static let draw = AlertItem(title: Text("Draw"), message: Text("a battle for the ages"), buttonTitle: Text("Rematch!"))
    static let human1Win = AlertItem(title: Text("Player 1 Wins"), message: Text("you are smarter than player 2"), buttonTitle: Text("Rematch"))
    static let human2Win = AlertItem(title: Text("Player 2 Wins"), message: Text("you are smarter than player 1"), buttonTitle: Text("Rematch"))
    static let locationOff = AlertItem(title: Text("Location Services are off"), message: Text("Turn on Location Services"), buttonTitle: Text("Ok"))
    static let locationRestricted = AlertItem(title: Text("Your Location Services are restricted"), message: Text("Turn on Location Services"), buttonTitle: Text("Ok"))
    static let locationDenied = AlertItem(title: Text("You denied Location Services"), message: Text("Turn on Location Services"), buttonTitle: Text("Ok"))

}
