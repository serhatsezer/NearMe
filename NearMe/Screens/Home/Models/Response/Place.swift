//
//  Place.swift
//  NearMe
//
//  Created by Serhat Sezer on 13.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import Foundation

struct Places: Codable {
    let results: [Place]?
    let status: String?
}

struct Place: Codable {
    let id: Id?
    let name: [Description]?
    let shortDescription: [Description]?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case image = "listimage"
        case shortDescription = "short_description"
    }
    
    struct Description: Codable {
        let lang: String?
        let value: String?
    }
    
    struct Id: Codable {
        let oid: String?
        
        enum CodingKeys: String, CodingKey {
            case oid = "$oid"
        }
    }
}
