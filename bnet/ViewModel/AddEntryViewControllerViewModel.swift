//
//  AddEntryViewControllerViewModel.swift
//  bnet
//
//  Created by Руслан Сафаргалеев on 14.08.2020.
//  Copyright © 2020 Руслан Сафаргалеев. All rights reserved.
//

import UIKit

class AddEntryViewControllerViewModel {
    
    var api: Api
    private var viewController: UIViewController
    
    init(api: Api, viewController: UIViewController) {
        self.api = api
        self.viewController = viewController
        self.api.networkDelegate = self
    }
    
    func addEntry(text: String) {
        api.addEntry(text: text)
    }
}

extension AddEntryViewControllerViewModel: NetworkManagerDelegate {
    func connectionWasRestored() {
        api.connectionWasRestored(viewController: viewController)
    }
    
    func showAlert() {
        api.showAlert(viewController: viewController)
    }
}
