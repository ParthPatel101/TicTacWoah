//
//  MapViewModel.swift
//  TicTacToe
//
//  Created by Parth Patel on 1/16/22.
//

import Foundation
import SwiftUI
import MapKit
final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    var locationManager: CLLocationManager?
    
    func checkLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyKilometer
        }
        else {
            alertItem = AlertContext.locationOff
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {return}
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            alertItem = AlertContext.locationRestricted
        case .denied:
            alertItem = AlertContext.locationDenied
        case .authorizedAlways, .authorizedWhenInUse:
            setRegion()
         @unknown default:
            break
        }

    }
    
    private func setRegion() {
        if let location =  locationManager?.location?.coordinate {
            region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05 ))
        }
        else {
            print("oh oh")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
 

