//
//  twoPlayerView.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/15/22.
//

import SwiftUI

struct twoPlayerView: View {
    
    @StateObject private var viewModel = twoPlayerViewModel()
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            Spacer()
            Text("MAN VS MAN")
                .foregroundColor(Color.white)
                .font(.title)
                .padding()
                .background(.linearGradient(colors: [Color.blue, Color.pink], startPoint: .top, endPoint: .bottom))
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 10)
            Text("Who Will Win?!")
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .font(.subheadline)
            GeometryReader { geo in
                VStack {
                    Text("Scores")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        .font(.subheadline)
                        .padding(.top, 50)
                    HStack {
                        VStack {
                            Label("Player 1", systemImage: "person")
                                .font(.title2)
                            Text("\(viewModel.playersScores.player1Score)")
                                .font(.title)
                        }
                        
                        .frame(minWidth: geo.size.width * 0.33, maxWidth: .infinity)
                        
                        
                        Rectangle().frame(width: geo.size.width * 0.005, height: geo.size.width * 0.13, alignment: .center)
                        VStack {
                            Label("Player 2", systemImage: "person")
                            
                                .font(.title2)
                            Text("\(viewModel.playersScores.player2Score)")
                                .font(.title)
                            
                        }
                        .padding()
                        .frame(minWidth: geo.size.width * 0.33, maxWidth: .infinity)
                    }
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.leading) .padding(.trailing)
                }.frame(height: geo.size.height * 0.1)
                
                GeometryReader {   Geometry in
                    VStack {
                        Spacer()
                        LazyVGrid(columns: viewModel.columns, spacing: 5) {
                            ForEach(0..<9) { i in
                                ZStack {
                                    GameCircleView(proxy: Geometry, difficultyColor: Color.red)
                                    placeObject(SystemImageName: viewModel.playersMoves[i]?.indicator ?? "")
                                }
                                .onTapGesture {
                                    if viewModel.human1turn {
                                        viewModel.processClickHuman1(for: i)
                                    }
                                    else {
                                        viewModel.processClickHuman2(for: i)
                                    }
                                    viewModel.human1turn.toggle()
                                }
                            }
                        }
                    }
                    .padding()
                    .alert(item: $viewModel.playersAlertItem) { alertItem  in
                        Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: {viewModel.reset()}))
                        
                    }
                }
            }
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct twoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        twoPlayerView()
    }
}
