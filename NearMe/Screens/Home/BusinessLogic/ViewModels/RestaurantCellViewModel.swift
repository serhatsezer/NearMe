//
//  RestaurantCellViewModel.swift
//  NearMe
//
//  Created by Serhat Sezer on 15.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import Foundation
import Alamofire

protocol RestaurantCellViewModelProtocol {
    var name: String { get }
    var shortDescription: String { get }
    var isFavorite: Bool { get set }
    var imageURL: URL { get }
}

struct RestaurantCellViewModel: RestaurantCellViewModelProtocol {
    
    /// Private variables
    private var place: Place
    private let favoritePersistManager: PersistManaging = FavoritePersistManager()
    
    init(place: Place) {
        self.place = place
    }
    
    /// Public variables
    var name: String {
        guard let placeName = place.name, let name = placeName.first?.value else {
            return ""
        }
        return name
    }
    
    var shortDescription: String {
        guard let shortPlaceDesc = place.shortDescription, let shortDesc = shortPlaceDesc.first?.value else {
            return ""
        }
        return shortDesc
    }
    
    var isFavorite: Bool {
        set {
            favoritePersistManager.save(key: venuId, value: newValue)
        }
        get {
            favoritePersistManager.getValue(with: venuId) as! Bool
        }
    }
    
    var imageURL: URL {
        guard let imageURL = place.image else {
            fatalError("Image must be set")
        }
        return URL(string: imageURL)!
    }
    
    var venuId: String {
        guard let id = place.id else {
            return ""
        }
        return id.oid!
    }
}

extension RestaurantCellViewModel: Equatable {
    static func == (lhs: RestaurantCellViewModel, rhs: RestaurantCellViewModel) -> Bool {
        return lhs.venuId == rhs.venuId
    }
}

protocol PersistManaging {
    func save(key: String, value: Any)
    func getValue(with key: String) -> Any?
}

class FavoritePersistManager: PersistManaging {
    private let defaults = UserDefaults.standard
    
    func save(key: String, value: Any) {
        defaults.set(value, forKey: key)
    }
    
    func getValue(with key: String) -> Any? {
        let value = defaults.value(forKey: key)
        return value ?? false
    }
}
