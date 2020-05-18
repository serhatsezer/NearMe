//
//  String+Localization.swift
//  NearMe
//
//  Created by Serhat Sezer on 19.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//

import Foundation
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
