//
//  HomeViewController.swift
//  NearMe
//
//  Created by Serhat Sezer on 12.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Swinject

class HomeViewController: UIViewController {
    
    // MARK: State Management
    enum State {
        case loading
        case loaded
        case failure(Error?)
    }
    
    // MARK: Private methods
    private lazy var tableView: UITableView = {
        $0.register(UINib(nibName: RestaurantTableViewCell.reuseIdentifier,
                                 bundle: nil),
                           forCellReuseIdentifier: RestaurantTableViewCell.reuseIdentifier)
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.tableFooterView = UIView()
        return $0
    }(UITableView(frame: .zero))
    
    private lazy var loaderHUB: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .gray))
    
    private var bag = DisposeBag()
    private let venuListDataSource = VenueLocationManager()
    private var state: State = .loading {
        didSet {
            stateDidChange()
        }
    }
    
    // MARK: Public methods
    public var viewModel: HomeViewModelProtocol!
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        startAutoRefresh()
    }
}

// MARK: Bindings
private extension HomeViewController {
    func setupUI() {
        title = "Discover".localized

        view.addSubview(loaderHUB)
        loaderHUB.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func startAutoRefresh() {
        state = .loading
        venuListDataSource.startUpdatingLocation()
        venuListDataSource.locationManager = { [weak self] location in
            self?.viewModel.input.searchLocation(lat: location.lat, long: location.long)
        }
    }
    
    func bindViewModel() {
        viewModel.output.places.bind(to: tableView
                .rx
                .items(cellIdentifier: RestaurantTableViewCell.reuseIdentifier, cellType: RestaurantTableViewCell.self)) { [weak self] (index, viewModel, cell) in
                    self?.state = .loaded
                    cell.viewModel = viewModel
                    cell.delegate = self
        }.disposed(by: bag)
        
        viewModel.output.error.subscribe(onNext: { [weak self] error in
            self?.state = .failure(error)
        }).disposed(by: bag)
        
    }
}

// MARK: State Management
private extension HomeViewController {
    func stateDidChange() {
        switch state {
        case .loading:
            loaderHUB.isHidden = false
            loaderHUB.startAnimating()
            tableView.isHidden = !loaderHUB.isHidden
        case .loaded:
            loaderHUB.isHidden = true
            loaderHUB.stopAnimating()
            tableView.isHidden = !loaderHUB.isHidden
        case let .failure(.some(error)):
            showAlert(title: "Error".localized, body: error.localizedDescription, alternateTitle: nil, okAction: nil)
            loaderHUB.stopAnimating()
            // can be add retry...
        default: break
        }
    }
}

extension HomeViewController: AlertShowable { }

// MARK: RestaurantCell Delegation
extension HomeViewController: RestaurantTableViewCellDelegate {
    func restaurantTableViewCell(_ cell: RestaurantTableViewCell, didTapFavoriteButton: Bool) {
        cell.viewModel?.isFavorite.toggle()
    }
}
