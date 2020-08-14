//
//  ViewControllerViewModel.swift
//  bnet
//
//  Created by Руслан Сафаргалеев on 14.08.2020.
//  Copyright © 2020 Руслан Сафаргалеев. All rights reserved.
//

import UIKit

class ViewControllerViewModel {

    private var entries: [Document]?
    var api = Api()
    private var tableView: UITableView
    private var viewController: UIViewController
    
    init(viewController: UIViewController, tableView: UITableView) {
        self.viewController = viewController
        self.tableView = tableView
        api.delegate = self
        api.networkDelegate = self
        api.startNewSession()
    }

    func numberOfRowsInSection() -> Int {
        return entries?.count ?? 0
    }
    
    func singleEntryViewModel(for indexPath: IndexPath) -> SingleEntryViewModel {
        return SingleEntryViewModel(document: entries![indexPath.row])
    }
}

extension ViewControllerViewModel: ApiDelegate {
    func updateViewController(data: [Document]) {
        entries = data
        tableView.reloadData()
    }
}

extension ViewControllerViewModel: NetworkManagerDelegate {
    func connectionWasRestored() {
        api.connectionWasRestored(viewController: viewController)
    }
    
    func showAlert() {
        api.showAlert(viewController: viewController)
    }
}
