//
//  HomeRestaurantService.swift
//  NearMe
//
//  Created by Serhat Sezer on 12.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol HomeRestaurantServiceProtocol {
    func getNearByPlace(from: UserCurrentLocation) -> Observable<Places>
}

class HomeRestaurantService: HomeRestaurantServiceProtocol {
    private var apiClient = MoyaProvider<HomeRestaurantEndpoint>()
    
    func getNearByPlace(from: UserCurrentLocation) -> Observable<Places> {
        return apiClient
                .rx
                .request(.getCurrentPlaces(from))
                .filterSuccessfulStatusAndRedirectCodes()
                .map(Places.self)
                .asObservable()
    }
    
}
