//
//  MapView.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/16/22.
//
import MapKit
import SwiftUI

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    
    var body: some View { 
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
            .onAppear{
                viewModel.checkLocationServicesIsEnabled()
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
