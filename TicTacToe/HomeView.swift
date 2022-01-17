//
//  HomeView.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/15/22.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        ScrollView {
            VStack {
                Text("Welcome to TicTacToe!")
                    .foregroundColor(Color.white)
                    .font(.title)
                    .padding()
                    .background(.linearGradient(colors: [Color.blue, Color.pink], startPoint: .top, endPoint: .bottom))
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 10)
                
                GeometryReader { geo in
                    Image("Icon.svg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width*0.8, height: geo.size.width*0.8)
                        .frame(width: geo.size.width, height: geo.size.width)
                }.scaledToFit()
                Text("How Would You Like To Play?")
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    .padding()
                
                HStack {
                    
                    NavigationLink {
                        GameView()
                    } label: {
                        Label("1-Player", systemImage: "person")
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Text("or")
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    
                    NavigationLink {
                        twoPlayerView()
                    } label: {
                        Label("2-Player", systemImage: "person.2")
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                }.shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 10)
                
            }
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
