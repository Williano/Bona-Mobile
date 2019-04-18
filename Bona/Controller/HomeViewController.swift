//
//  HomeViewController.swift
//  Bona
//
//  Created by William Kpabitey Kwabla on 4/11/19.
//  Copyright © 2019 William Kpabitey Kwabla. All rights reserved.
//

import UIKit
import Kingfisher


class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var categories = [Category]()
    var articles = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        // Enable self sizing cells
//        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        CategoryController.shared.fetchCategories { (categories) in
            guard let categories = categories else {
                return
            }
            
            self.updateCategoryUI(with: categories)
        }
        
        ArticleController.shared.fetchArticles { (articles) in
            guard let articles = articles else {
                return
            }

            self.updateArticleUI(with: articles)
        }
    }
    
    
    // MARK: - Custom Methods
    
    func updateCategoryUI(with catgories: [Category]){
        DispatchQueue.main.async {
            self.categories = catgories
            self.collectionView.reloadData()
        }
    }
    
    func updateArticleUI(with articles: [Article]){
        DispatchQueue.main.async {
            self.articles = articles
            self.tableView.reloadData()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCellIdentifier", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryTitle.text = categories[indexPath.row].name
        let url = URL(string: categories[indexPath.row].imageURL.absoluteString)
        cell.categoryImage.kf.setImage(with: url)
        return cell
    }
    

}

extension HomeViewController: UITableViewDelegate {
    
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCellIdentifier", for: indexPath) as! ArticleTableViewCell
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        cell.articleTitle.text = articles[indexPath.row].title
        cell.articleCategory.text = articles[indexPath.row].category.uppercased()
        cell.articleAuthor.text = articles[indexPath.row].author
        
        let url = URL(string: articles[indexPath.row].image.absoluteString)
        cell.articleImage.kf.setImage(with: url)
        
        let dateString = articles[indexPath.row].datePublished
        let dateComponents = dateString.components(separatedBy: "T")
        let splitDate = dateComponents[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        let newDateFormat = DateFormatter()
        newDateFormat.dateFormat = "MMMM dd"
        let dateOutput = dateFormatter.date(from: splitDate)
        
        cell.articleDate?.text = newDateFormat.string(from: dateOutput!)

        return cell
    }
    
    
}
