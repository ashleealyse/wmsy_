//
//  ToolbarViewController.swift
//  wmsy
//
//  Created by C4Q on 5/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

protocol ToolbarViewControllerDelegate: class {
    func toolbar(_ toolbar: ToolbarViewController, selectedCategory category: Category) -> Void
    func toolbar(_ toolbar: ToolbarViewController, deselectedCategory category: Category) -> Void
}

class ToolbarViewController: UIViewController {
    
    let toolbarView = ToolbarView()
    var delegate: ToolbarViewControllerDelegate?
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolbarView.categoryCV.delegate = self
    }
}

extension ToolbarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCategoryCell", for: indexPath) as! WhimCategoryCollectionViewCell
        var categoryImage: UIImage
        switch categories[indexPath.row] {
        case .wmsy:
            categoryImage = #imageLiteral(resourceName: "wmsyCategoryIcon")
        case .animals:
            categoryImage = #imageLiteral(resourceName: "animalsCategoryIcon")
        case .arts:
            categoryImage = #imageLiteral(resourceName: "artsCategoryIcon")
        case .coffee:
            categoryImage = #imageLiteral(resourceName: "coffeeCategoryIcon")
        case .drinks:
            categoryImage = #imageLiteral(resourceName: "drinksCategoryIcon")
        case .entertainment:
            categoryImage = #imageLiteral(resourceName: "entertainmentCategoryIcon")
        case .games:
            categoryImage = #imageLiteral(resourceName: "gamesCategoryIcon")
        case .restaurants:
            categoryImage = #imageLiteral(resourceName: "restaurantsCategoryIcon")
        case .shopping:
            categoryImage = #imageLiteral(resourceName: "shoppingCategoryIcon")
        case .sports:
            categoryImage = #imageLiteral(resourceName: "sportsCategoryIcon")
        }
        cell.categoryImage.image = categoryImage
        return cell
    }
}

extension ToolbarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        delegate?.toolbar(self, selectedCategory: category)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCategoryCell", for: indexPath) as! WhimCategoryCollectionViewCell
        UIView.animate(withDuration: 0.4) {
            cell.categoryImage.backgroundColor = .black
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        delegate?.toolbar(self, deselectedCategory: category)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCategoryCell", for: indexPath) as! WhimCategoryCollectionViewCell
        UIView.animate(withDuration: 0.4) {
            cell.categoryImage.backgroundColor = .white
        }
    }
}
