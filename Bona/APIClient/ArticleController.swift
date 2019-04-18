//
//  ArticleController.swift
//  Bona
//
//  Created by William Kpabitey Kwabla on 4/10/19.
//  Copyright © 2019 William Kpabitey Kwabla. All rights reserved.
//

import Foundation


class ArticleController {
    
    static let shared = ArticleController()
    
    let baseURL = URL(string: "http://127.0.0.1:8000/api/v1/blog")
    
    func fetchArticles(completion: @escaping ([Article]?) -> Void){
        // URL to get data from
        let articleURL = baseURL?.appendingPathComponent("articles")
        
        // Create a task to get the articles from the endpoint
        let task = URLSession.shared.dataTask(with: articleURL!) { (data, response, error) in
            
            // ensure there is no error for this HTTP response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            
            // ensure there is data returned from this HTTP response
            guard let data = data else {
                print("No data")
                return
            }
            
            // Parse JSON into Dictionary that contains Array of Article struct using JSONDecoder
            guard let articles = try? JSONDecoder().decode([Article].self, from: data) else {
                print("Error: Couldn't decode data into dictionary of array of articles")
                return
            }
            
            // Pass decoded data to completion handler
            completion(articles)
            
            
        }
        
        // execute the HTTP request
        task.resume()
    }
    
    func fetchCategoryArticles(categoryName: String, completion: @escaping ([Article]?) -> Void){
        // URL to get data from
       let categoryArticleURL = baseURL?.appendingPathComponent(categoryName)
        
          // Create a task to get the articles from the endpoint
        let task = URLSession.shared.dataTask(with: categoryArticleURL!) { (data, response, error) in
            
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
            
             // Parse JSON into Dictionary that contains Array of Article struct using JSONDecoder
            guard let categoryArticles = try? JSONDecoder().decode([Article].self, from: data) else {
                print("Error: Couldn't decode data into dictionary of array of articles")
                return
            }
            
            // Pass decoded data to completion handler
            completion(categoryArticles)
            
        }
        
        // execute the HTTP request
        task.resume()
    }
}
