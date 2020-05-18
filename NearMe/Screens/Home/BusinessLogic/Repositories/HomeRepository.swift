//
//  HomeRepository.swift
//  NearMe
//
//  Created by Serhat Sezer on 12.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeRepositoryProtocol {
    init(service: HomeRestaurantServiceProtocol)
    func getNearyPlaces(from currentLocation: UserCurrentLocation) -> Observable<Places>
}

class HomeRepository: HomeRepositoryProtocol {
    private let service: HomeRestaurantServiceProtocol
    
    required init(service: HomeRestaurantServiceProtocol) {
        self.service = service
    }
    
    func getNearyPlaces(from currentLocation: UserCurrentLocation) -> Observable<Places> {
        // reason to seperation do something to persist to local caching...
        // or checking something else
        return service.getNearByPlace(from: currentLocation)
    }
}
