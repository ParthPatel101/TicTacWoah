//
//  MapModel.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/16/22.
//

import Foundation
import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 40.453506, longitude: -74.291357)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05 )
}
