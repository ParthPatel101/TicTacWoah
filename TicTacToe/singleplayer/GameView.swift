//
//   GameView.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/14/22.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    init()  {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.systemPink.withAlphaComponent(0.9)
        let attributes: [NSAttributedString.Key:Any] = [.foregroundColor: UIColor.white  ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                Text("MAN VS MACHINE")
                    .foregroundColor(Color.white)
                    .font(.title)
                    .padding()
                    .background(.linearGradient(colors: [Color.blue, Color.pink], startPoint: .top, endPoint: .bottom))
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 10)
                Text("Who Will Win?!")
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    .font(.subheadline)
                VStack {
                    Text("Scores")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        .font(.subheadline)
                        .padding()
                    HStack {
                        VStack {
                            Label("Player", systemImage: "person")
                                .font(.title2)
                            Text("\(viewModel.scores.playerScore)")
                                .font(.title)
                        } .padding()
                        
                        
                        
                        Rectangle().frame(width: 2, height: 50, alignment: .center)
                        VStack {
                            Label("AI", systemImage: "brain")
                            
                                .font(.title2)
                            Text("\(viewModel.scores.computerScore)")
                                .font(.title)
                            
                        }
                        .padding()
                    }
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.leading) .padding(.trailing)
                }
                VStack {
                    Text("Choose AI Difficulty!")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        .font(.subheadline)
                    Picker(
                        selection: $viewModel.gameDifficulty,
                        label: Text("Choose Difficulty")
                            .foregroundColor(Color.pink),
                        content: {
                            ForEach (viewModel.difficultyEmojis.indices) { index in
                                Image(systemName: viewModel.difficultyEmojis[index])
                                    .tag(viewModel.difficultyEmojis[index])
                                
                            }
                        })
                        .pickerStyle(SegmentedPickerStyle())
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 10)
                        .disabled(viewModel.gameStarted)
                        .foregroundColor(Color.white)
                        .padding()
                    GeometryReader { geometry in
                        VStack {
                            LazyVGrid(columns: viewModel.columns, spacing: 5) {
                                ForEach(0..<9) { i in
                                    ZStack {
                                        GameCircleView(proxy: geometry, difficultyColor: viewModel.findDifficultyColor())
                                        placeObject(SystemImageName: viewModel.moves[i]?.indicator ?? "")
                                    }
                                    .onTapGesture {
                                        viewModel.gameStarted = true
                                        viewModel.processClick(for: i)
                                    }
                                }
                            }
                            .disabled(viewModel.wait)
                        }
                        
                        
                        .padding()
                        .alert(item: $viewModel.alertItem) { alertItem  in
                            Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {viewModel.reset()}))
                            
                        }
                    }.scaledToFit()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameView()
        }
    }
}
