//
//  FormViewModel.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/17/22.
//

import Foundation

final class FormViewModel: ObservableObject {
    @Published var user: User = User(fname: "", lname: "", bday: Date(), wantsNews: false, followers: 0) {
        didSet {
            saveData()
        }
    }
    let infoKey:String = "userInfo"
    
    init() {
        getData()
    }
    
    func getData() {
        guard
            let data = UserDefaults.standard.data(forKey: infoKey),
            let savedData = try? JSONDecoder().decode(User.self, from: data)
        else {return}
        self.user = savedData
    }
    
    func saveData() {
        if let encodedData = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encodedData, forKey: infoKey)
        }
    }
}
