//
//  FormModel.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/18/22.
//

import Foundation

struct User: Identifiable, Codable {
    
    let id:String
    var firstName: String = ""
    var lastName: String = ""
    var birthDate: Date = Date()
    var sendNews: Bool = false
    var followers: Int = 0
    
    init(id:String = UUID().uuidString, fname: String, lname: String, bday: Date, wantsNews: Bool, followers: Int) {
        self.id = id
        firstName = fname
        lastName = lname
        birthDate = bday
        sendNews = wantsNews
        self.followers = followers
    }
}
