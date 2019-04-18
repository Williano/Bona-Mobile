//
//  Category.swift
//  Bona
//
//  Created by William Kpabitey Kwabla on 4/10/19.
//  Copyright © 2019 William Kpabitey Kwabla. All rights reserved.
//

import Foundation


struct Category: Codable {
    var name: String
    var imageURL: URL
    
        enum CodingKeys: String, CodingKey {
            case name
            case imageURL = "image"
        }
}
