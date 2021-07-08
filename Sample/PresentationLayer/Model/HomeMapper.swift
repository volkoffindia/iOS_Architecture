//
//  HomeMapper.swift
//  Sample
//
//  Created by Volkoff India on 15/06/21.
//

import Foundation

//HomeResponse
class  HomeResponse : Codable {
    
    var data : [ProductData]?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent([ProductData].self, forKey: .data)
    }
}

class ProductData: Codable {
    
    var cost : Int?
    var name : String?
    var description : String?
    var product_images : String?

    enum CodingKeys: String, CodingKey {
        case cost, name, description, product_images
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cost = try container.decodeIfPresent(Int.self, forKey: .cost)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        product_images = try container.decodeIfPresent(String.self, forKey: .product_images)
    }
}

