//
//  FormView.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/17/22.
//

import SwiftUI

struct FormView: View {
    
    @StateObject var viewModel = FormViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section("Bio") {
                    TextField("First Name", text: $viewModel.user.firstName)
                    TextField("Last Name", text: $viewModel.user.lastName)
                    DatePicker("Birthday", selection: $viewModel.user.birthDate, displayedComponents: .date)
                }
                Section("Actions") {
                    Toggle("Send Newsletter?", isOn: $viewModel.user.sendNews)
                        .toggleStyle(SwitchToggleStyle(tint: Color.pink))
                    Stepper("Followers", value: $viewModel.user.followers, in: 1...1000)
                    Text("You have \(viewModel.user.followers) followers")
                    Link("Terms of Service", destination: URL(string: "https://www.youtube.com")!)
                }
                NavigationLink("Continue", destination: HomeView())
            }
            .navigationTitle(Text("Account"))
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        hideKeyBoard()
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
        }.accentColor(.pink)
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyBoard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
