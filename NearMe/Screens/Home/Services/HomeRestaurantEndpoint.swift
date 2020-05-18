//
//  HomeRestaurantEndpoint.swift
//  NearMe
//
//  Created by Serhat Sezer on 15.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import Moya

enum HomeRestaurantEndpoint {
    case getCurrentPlaces(UserCurrentLocation)
}

extension HomeRestaurantEndpoint: TargetType {
    var baseURL: URL {
        return AppConfig.baseURL
    }
    
    var path: String {
        return "venues"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var headers: [String : String]? {
        return AppConfig.headers
    }
    
    var task: Task {
        switch self {
        case .getCurrentPlaces(let userCurrentLocation):
            return .requestParameters(parameters: ["lat": userCurrentLocation.lat,
                                                   "lon": userCurrentLocation.long],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
}
