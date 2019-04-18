//
//  Category.swift
//  Bona
//
//  Created by William Kpabitey Kwabla on 4/10/19.
//  Copyright © 2019 William Kpabitey Kwabla. All rights reserved.
//

import Foundation


class CategoryController {
    
    static let shared = CategoryController()
    
    let baseURL = URL(string: "http://127.0.0.1:8000/api/v1/blog")
    
    func fetchCategories(completion: @escaping ([Category]?) -> Void){
        // URL to get data from
        let categoryURL = baseURL?.appendingPathComponent("categories")
        
        // Create a task to get the categories from the endpoint
        let task = URLSession.shared.dataTask(with: categoryURL!) { (data, response, error) in
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print("error: \(error!)")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let data = data else {
                print("No data")
                return
            }
            
            // Parse JSON into Dictionary that contains Array of Category struct using JSONDecoder
            guard let categories = try? JSONDecoder().decode([Category].self, from: data) else {
                print("Error: Couldn't decode data into dictionary of array of articles")
                return
            }
            
            // pass decoded data to completion handler
            completion(categories)
        }
        
        // execute the HTTP request
        task.resume()
    }
}
