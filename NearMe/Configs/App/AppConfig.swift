//
//  AppConfig.swift
//  NearMe
//
//  Created by Serhat Sezer on 13.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import Foundation

enum AppConfig {
    static var baseURL: URL { return URL(string:"https://restaurant-api.com")! }
    static var headers: [String: String]? = nil
    
    enum Content {
        static var visibleItems = 15
        static var refreshTime = TimeInterval(10)
    }
}
