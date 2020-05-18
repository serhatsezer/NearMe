//
//  HomeViewModel.swift
//  NearMe
//
//  Created by Serhat Sezer on 12.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeViewModelInput {
    func searchLocation(lat: String, long: String)
}

protocol HomeviewModelOutput {
    var places: Observable<[RestaurantCellViewModel]> { get }
    var error: Observable<Error> { get }
}

protocol HomeViewModelProtocol {
    var input: HomeViewModelInput { get }
    var output: HomeviewModelOutput { get }
}

struct HomeViewModel: HomeViewModelProtocol {
    
    /// Private variables
    private let repository: HomeRepositoryProtocol
    private let bag = DisposeBag()
    private var selectedVenues = [String]()
    
    /// Outputs
    private let placesSubject = PublishSubject<[RestaurantCellViewModel]>()
    private let placesErrorSubject = PublishSubject<Error>()

    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
    /// View model lifecycle
    var input: HomeViewModelInput {
        return self
    }
    
    var output: HomeviewModelOutput {
        return self
    }
}

// MARK: HomeViewModel Inputs
extension HomeViewModel: HomeViewModelInput {
    
    func searchLocation(lat: String, long: String) {
        repository
            .getNearyPlaces(from: UserCurrentLocation(lat: lat, long: long))
            .subscribe(onNext: { places in
                self.handleResponse(places: places.results)
            }, onError: { error in
                self.placesErrorSubject.onNext(error)
            }).disposed(by: bag)
    }
    
    private func handleResponse(places: [Place]?) {
        if let places = places {
            let viewModels = Array(places.map(RestaurantCellViewModel.init).prefix(AppConfig.Content.visibleItems))
            self.placesSubject.onNext(viewModels)
        }
    }
    
    mutating func setSelectedVenue(_ venueId: String) {
        selectedVenues.append(venueId)
    }
    
}

// MARK: HomeViewModel Outputs
extension HomeViewModel: HomeviewModelOutput {
    var places: Observable<[RestaurantCellViewModel]> {
        return placesSubject.asObservable()
    }
    
    var error: Observable<Error> {
        return placesErrorSubject.asObservable()
    }
}
