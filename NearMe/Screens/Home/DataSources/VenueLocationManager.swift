//
//  VenuListDataSource.swift
//  NearMe
//
//  Created by Serhat Sezer on 16.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import Foundation

class VenueLocationManager: LocationManager {
    private var fetcherTimer: Timer?
    // Since timer deallocate after fire we need to strongly
    public var locationManager: ((UserCurrentLocation) -> Void)?
    
    private var userLocations: [UserCurrentLocation] = [
        UserCurrentLocation(lat: "60.163904", long: "24.926373"),
        UserCurrentLocation(lat: "60.164523", long: "24.933368"),
        UserCurrentLocation(lat: "60.162858", long: "24.940749"),
        UserCurrentLocation(lat: "60.158908", long: "24.880325"),
        UserCurrentLocation(lat: "60.162666", long: "24.912082"),
        UserCurrentLocation(lat: "60.172657", long: "24.913627"),
        UserCurrentLocation(lat: "60.168985", long: "24.928733"),
        UserCurrentLocation(lat: "60.180426", long: "24.924098"),
        UserCurrentLocation(lat: "60.185206", long: "24.974567"),
        UserCurrentLocation(lat: "60.188278", long: "24.957229")
    ]
    
    func startUpdatingLocation() {
        invalidateTimer()
        locationManager?(userLocations.randomElement()!)
        Timer.scheduledTimer(timeInterval: AppConfig.Content.refreshTime,
                             target: self,
                             selector: #selector(fetchRandomLocation),
                             userInfo: nil,
                             repeats: true)
    }
    
    func stopUpdatingLocation() {
        invalidateTimer()
    }
    
    private func invalidateTimer() {
        guard let timer = fetcherTimer else { return }
        timer.invalidate()
    }
    
    @objc private func fetchRandomLocation() {
        locationManager?(userLocations.randomElement()!)
    }
}
