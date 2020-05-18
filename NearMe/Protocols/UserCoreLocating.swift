//
//  UserCoreLocating.swift
//  NearMe
//
//  Created by Serhat Sezer on 16.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import Foundation

protocol LocationManager {
    func startUpdatingLocation()
    func stopUpdatingLocation()
    var locationManager: ((UserCurrentLocation) -> Void)? { get }
}
