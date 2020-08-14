//
//  AddEntryViewController.swift
//  bnet
//
//  Created by Руслан Сафаргалеев on 13.08.2020.
//  Copyright © 2020 Руслан Сафаргалеев. All rights reserved.
//

import UIKit

class AddEntryViewController: UIViewController {
    
    var viewModel: AddEntryViewControllerViewModel?
    var api: Api? {
        didSet{
            viewModel = AddEntryViewControllerViewModel(api: api!, viewController: self)
        }
    }
    let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        setupNavigationItems()
    }
    
    func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
        if sender.title == "Сохранить" {
            if let text = textView.text {
                guard let viewModel = viewModel else { return }
                viewModel.addEntry(text: text)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func setupTextView() {
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.font = UIFont.systemFont(ofSize: 16)
    }
}
