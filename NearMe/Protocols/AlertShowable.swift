//
//  AlertShowable.swift
//  NearMe
//
//  Created by Serhat Sezer on 19.4.2020.
//  Copyright © 2020 Serhat Sezer. All rights reserved.
//
import UIKit

protocol AlertShowable { }

extension AlertShowable where Self: UIViewController {
    func showAlert(title: String, body: String, alternateTitle: String? = nil, okAction: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let OKButton = UIAlertAction(title: "OK".localized, style: .default, handler: okAction)
        alertController.addAction(OKButton)
        present(alertController, animated: true, completion: nil)
        
    }
}
