//
//  Resuable.swift
//  NearMe
//
//  Created by Serhat Sezer on 12.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import Foundation

protocol Resuable {
    static var reuseIdentifier: String { get }
}

extension Resuable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
