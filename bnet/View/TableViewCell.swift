//
//  TableViewCell.swift
//  bnet
//
//  Created by Руслан Сафаргалеев on 13.08.2020.
//  Copyright © 2020 Руслан Сафаргалеев. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let createdLabel = UILabel()
    let modifiedLabel = UILabel()
    
    weak var viewModel: SingleEntryViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            setupLabels(viewModel: viewModel)
        }
    }
    
    func setupLabels(viewModel: SingleEntryViewModel) {
        titleLabel.removeFromSuperview()
        createdLabel.removeFromSuperview()
        modifiedLabel.removeFromSuperview()
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7).isActive = true
        titleLabel.numberOfLines = 0
        titleLabel.text = viewModel.getTitle(text: viewModel.text)
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        
        addSubview(createdLabel)
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        createdLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7).isActive = true
        createdLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        createdLabel.trailingAnchor.constraint(equalTo: centerXAnchor).isActive = true
        createdLabel.text = "Cоздано: " + viewModel.dateCreated
        createdLabel.font = UIFont.systemFont(ofSize: 12)
        createdLabel.textColor = .lightGray
        
        if viewModel.dateModified != viewModel.dateCreated {
            addSubview(modifiedLabel)
            modifiedLabel.translatesAutoresizingMaskIntoConstraints = false
            modifiedLabel.topAnchor.constraint(equalTo: createdLabel.bottomAnchor, constant: 7).isActive = true
            modifiedLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7).isActive = true
            modifiedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7).isActive = true
            modifiedLabel.text = "Изменено: " + viewModel.dateModified
            modifiedLabel.font = UIFont.systemFont(ofSize: 12)
            modifiedLabel.textColor = .lightGray
        } else {
            createdLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7).isActive = true
        }
    }
}
