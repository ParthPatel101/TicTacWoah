//
//  FormViewModel.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/17/22.
//

import Foundation

final class FormViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var birthDate: Date = Date()
    @Published var sendNews: Bool = false
    @Published var followers: Int = 0
}
