//
//  FavoriteButton.swift
//  NearMe
//
//  Created by Serhat Sezer on 12.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    private let normalStateImage = UIImage(named: "favorite_default")
    private let selectedStateImage = UIImage(named: "favorite-selected")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

private extension FavoriteButton {
    func setupUI() {
        setBackgroundImage(normalStateImage, for: .normal)
        setBackgroundImage(selectedStateImage, for: .selected)
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        imageView?.contentMode = .scaleAspectFit
    }
}
