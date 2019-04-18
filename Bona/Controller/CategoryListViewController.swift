//
//  CategoryListViewController.swift
//  Bona
//
//  Created by William Kpabitey Kwabla on 4/17/19.
//  Copyright © 2019 William Kpabitey Kwabla. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellIdentifier = "CategoryListCollectionViewCellIdentifier"
    
    var categories = [Category]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
        CategoryController.shared.fetchCategories { (categories) in
            guard let categories = categories else {
                return
            }
            
            self.updateCategoryUI(with: categories)
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
    
    // MARK: - Custom Methods
    func updateCategoryUI(with categories: [Category]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.collectionView.reloadData()
        }
        
    }

}

extension CategoryListViewController: UICollectionViewDelegate {
    
}

extension CategoryListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryListCollectionViewCell
        
        // Configure the cell
        let url = URL(string: categories[indexPath.row].imageURL.absoluteString)
        cell.categoryImageView?.kf.setImage(with: url)
        
        cell.categoryTitleLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    
}
