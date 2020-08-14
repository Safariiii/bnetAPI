//
//  DetailViewController.swift
//  bnet
//
//  Created by Руслан Сафаргалеев on 13.08.2020.
//  Copyright © 2020 Руслан Сафаргалеев. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    weak var viewModel: SingleEntryViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            setupLabels(viewModel: viewModel)
        }
    }

    func setupLabels(viewModel: SingleEntryViewModel) {
        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        titleLabel.numberOfLines = 0
        titleLabel.text = viewModel.text
        titleLabel.textAlignment = .center
        
        let createdLabel = UILabel()
        view.addSubview(createdLabel)
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        createdLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        createdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        createdLabel.text = "Создано: " + viewModel.dateCreated
        createdLabel.font = UIFont.systemFont(ofSize: 14)
        
        if viewModel.dateCreated != viewModel.dateModified {
            let modifiedLabel = UILabel()
            view.addSubview(modifiedLabel)
            modifiedLabel.translatesAutoresizingMaskIntoConstraints = false
            modifiedLabel.topAnchor.constraint(equalTo: createdLabel.bottomAnchor, constant: 10).isActive = true
            modifiedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            modifiedLabel.text = "Изменено: " + viewModel.dateModified
            modifiedLabel.font = UIFont.systemFont(ofSize: 14)
        }
    }
}
