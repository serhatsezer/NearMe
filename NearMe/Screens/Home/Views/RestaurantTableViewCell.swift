//
//  RestaurantTableViewCell.swift
//  NearMe
//
//  Created by Serhat Sezer on 12.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import UIKit
import Kingfisher

protocol RestaurantTableViewCellDelegate: AnyObject {
    func restaurantTableViewCell(_ cell: RestaurantTableViewCell, didTapFavoriteButton: Bool)
}

class RestaurantTableViewCell: UITableViewCell {
    
    weak var delegate: RestaurantTableViewCellDelegate?
    
    public var viewModel: RestaurantCellViewModel? {
        didSet {
            guard let vm = viewModel else { return }
            configureUI(with: vm)
        }
    }
    
    @IBOutlet weak var restaurantImageView: UIImageView! {
        didSet {
            self.restaurantImageView.layer.cornerRadius = 10
            self.restaurantImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var favoriteButton: FavoriteButton!
    @IBOutlet weak var shortDescLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
}

// MARK: UI Config
private extension RestaurantTableViewCell {
    func commonInit() {
        selectionStyle = .none
        separatorInset = Insets.cellSeperator
    }
    
    func configureUI(with viewModel: RestaurantCellViewModel) {
        nameLabel.text = viewModel.name
        shortDescLabel.text = viewModel.shortDescription
        favoriteButton.isSelected = viewModel.isFavorite
        // caching, fading, loading the image
        restaurantImageView.kf.indicatorType = .activity
        restaurantImageView.kf.setImage(
            with: viewModel.imageURL,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}

// MARK: Extensions
extension RestaurantTableViewCell: Resuable { }

// MARK: Actions
extension RestaurantTableViewCell {
    @IBAction private func favoriteButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        delegate?.restaurantTableViewCell(self, didTapFavoriteButton: sender.isSelected)
    }
}
