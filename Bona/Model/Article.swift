//
//  Article.swift
//  Bona
//
//  Created by William Kpabitey Kwabla on 4/10/19.
//  Copyright © 2019 William Kpabitey Kwabla. All rights reserved.
//

import Foundation


struct Article: Codable {
    var category: String
    var title: String
    var author: String
    var image: URL
    var body: String
    var datePublished: String
    
    enum CodingKeys: String, CodingKey{
        case category
        case title
        case author
        case image = "image"
        case body
        case datePublished = "date_published"
    }
}
