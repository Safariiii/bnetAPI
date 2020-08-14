//
//  ViewController.swift
//  bnet
//
//  Created by Руслан Сафаргалеев on 13.08.2020.
//  Copyright © 2020 Руслан Сафаргалеев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    var viewModel: ViewControllerViewModel?
    var indexPathForSelectedRow: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupTableView()
        viewModel = ViewControllerViewModel(viewController: self, tableView: tableView)
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить запись", style: .plain, target: self, action: #selector(addButtonPressed))
    }
    
    @objc func addButtonPressed() {
        performSegue(withIdentifier: "addEntry", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addEntry" {
            let destinationVC = segue.destination as! AddEntryViewController
            guard let viewModel = viewModel else { return }
            destinationVC.api = viewModel.api
        } else if segue.identifier == "goToDetailViewController" {
            let destinationVC = segue.destination as! DetailViewController
            guard let viewModel = viewModel, let indexPath = indexPathForSelectedRow else { return }
            destinationVC.viewModel = viewModel.singleEntryViewModel(for: indexPath)
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPathForSelectedRow = indexPath
        performSegue(withIdentifier: "goToDetailViewController", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        sectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sectionView.backgroundColor = .red
        
        let titleLabel = UILabel()
        sectionView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: sectionView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: sectionView.centerXAnchor).isActive = true
        titleLabel.text = "Все записи"
        titleLabel.textColor = .white
        
        return sectionView
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0}
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell        
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.singleEntryViewModel(for: indexPath)
        tableViewCell.viewModel = cellViewModel
        
        return tableViewCell
    }
}
