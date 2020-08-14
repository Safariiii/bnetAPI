//
//  Api.swift
//  bnet
//
//  Created by Руслан Сафаргалеев on 14.08.2020.
//  Copyright © 2020 Руслан Сафаргалеев. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ApiDelegate {
    func updateViewController(data: [Document])
}

protocol NetworkManagerDelegate {
    func showAlert()
    func connectionWasRestored()
}

class Api {
    private let token = "rg2wIW2-BL-RP1cnSr"
    private let baseURL = "https://bnet.i-partner.ru/testAPI/"
    var sessionID: String?
    var delegate: ApiDelegate?
    var networkDelegate: NetworkManagerDelegate?
    
    func startNewSession() {
        if isNetworkReachable() {
            let headers = ["token" : token]
            let parameters: [String : String] = [
                "a" : "new_session"
            ]
            Alamofire.request(baseURL, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
                if response.result.isSuccess {
                    let jsonResponse = JSON(response.result.value!)
                    let id = jsonResponse["data"]["session"].stringValue
                    self.sessionID = id
                }
            }
        } else {
            networkDelegate?.showAlert()
        }
    }
    
    func addEntry(text: String) {
        if isNetworkReachable() {
            let headers = ["token" : token]
            let parameters: [String : String] = [
                "a" : "add_entry",
                "session" : sessionID!,
                "body" : text
            ]
            Alamofire.request(baseURL, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
                if response.result.isSuccess {
                    self.getEntries()
                }
            }
        } else {
            networkDelegate?.showAlert()
        }
    }
    
    func getEntries() {
        if isNetworkReachable() {
            let headers = ["token" : token]
            let parameters: [String : String] = [
                "a" : "get_entries",
                "session" : sessionID!,
            ]
            Alamofire.request(baseURL, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
                if response.result.isSuccess {
                    let jsonResponse = JSON(response.result.value!)
                    let data = jsonResponse["data"][0]
                    var finalData: [Document] = []
                    
                    for i in 0..<data.count {
                        let dateCreated = data[i]["da"].stringValue
                        let dateModified = data[i]["dm"].stringValue
                        let text = data[i]["body"].stringValue
                        finalData.append(Document(text: text, dateCreated: dateCreated, dateModified: dateModified))
                    }
                    self.delegate?.updateViewController(data: finalData)
                }
            }
        } else {
            networkDelegate?.showAlert()
        }
    }
    
    func showAlert(viewController: UIViewController) {
        let alert = UIAlertController(title: "Ошибка", message: "Отсутствует подключение к интернету, проверьте свое соединение и попробуйте обновить данные", preferredStyle: .alert)
        let action = UIAlertAction(title: "Обновить данные", style: .default) { (action) in
            self.refreshData()
        }
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func connectionWasRestored(viewController: UIViewController) {
        let alert = UIAlertController(title: "Ура!", message: "Соединение успешно восстановленно", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    private func isNetworkReachable() -> Bool {
        let networkManager = NetworkReachabilityManager(host: "https://bnet.i-partner.ru/testAPI/")
        
        return networkManager?.isReachable ?? false
    }
    
    private func refreshData() {
        if sessionID != nil {
            if isNetworkReachable() {
                networkDelegate?.connectionWasRestored()
            } else {
                networkDelegate?.showAlert()
            }
        } else {
            if isNetworkReachable() {
                startNewSession()
                networkDelegate?.connectionWasRestored()
            } else {
                networkDelegate?.showAlert()
            }
        }
    }
}
