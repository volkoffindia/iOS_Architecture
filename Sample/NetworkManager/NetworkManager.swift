//
//  NetworkManager.swift
//  Sample
//
//  Created by Volkoff India on 15/06/21.
//

import Foundation

let NETWORK_MANAGER = NetworkManager.sharedInstance
typealias isCompleted = () -> ()
typealias completionHandler = JSONCompletionHandler
typealias JSONCompletionHandler = (Data?) -> Void

class NetworkManager {
    
    class var sharedInstance :NetworkManager {
        struct Singleton {
            static let instance = NetworkManager()
        }
        return Singleton.instance
    }
    

    //MARK:- POST
    func withGET(completionHandler: @escaping JSONCompletionHandler) {
        
        var components = URLComponents(string: "http://staging.php-dev.in:8844/trainingapp/api/products/getList")
        components?.queryItems = [URLQueryItem(name: "product_category_id", value: "1")]

        var request = URLRequest(url: components!.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            completionHandler(data)
        }).resume()
    }
}

