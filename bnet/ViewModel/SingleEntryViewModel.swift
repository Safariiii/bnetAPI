//
//  TableViewCellViewModel.swift
//  bnet
//
//  Created by Руслан Сафаргалеев on 14.08.2020.
//  Copyright © 2020 Руслан Сафаргалеев. All rights reserved.
//

import UIKit

class SingleEntryViewModel {
    
    private let document: Document
    let text: String
    var dateCreated: String = ""
    var dateModified: String = ""
    
    init(document: Document) {
        self.document = document
        self.text = document.text
        self.dateCreated = getDate(date: document.dateCreated)
        self.dateModified = getDate(date: document.dateModified)
    }
    
    func getTitle(text: String) -> String {
        var title = ""
        for letter in text {
            if title.count < 200 {
                title.append(letter)
            } else {
                return title
            }
        }
        return title
    }
    
    private func getDate(date: String) -> String {
        let seconds = Date(timeIntervalSince1970: (Double(date)!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, dd.MM.yyyy г."
        
        return dateFormatter.string(from: seconds)
    }
}
