//
//  HomeModel.swift
//  Sample
//
//  Created by Volkoff India on 15/06/21.
//

import Foundation

let HOME_MODEL = HomeModel.sharedInstance

class HomeModel: NSObject {
    
    class var sharedInstance :HomeModel {
        struct Singleton {
            static let instance = HomeModel()
        }
        return Singleton.instance
    }

    //Login API
    var productList : [ProductData]?
    func getProdutData(completionHandler: @escaping isCompleted) {
        NETWORK_MANAGER.withGET() { (rData) in
            if let rData = rData {
                if let response = try? JSONDecoder().decode(HomeResponse.self, from: rData){
                    if let data = response.data {
                        self.productList = data
                        completionHandler()
                    }
                }
            }
        }
    }
}
