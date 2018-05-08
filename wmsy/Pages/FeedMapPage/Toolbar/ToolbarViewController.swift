//
//  ToolbarViewController.swift
//  wmsy
//
//  Created by C4Q on 5/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

protocol ToolbarViewControllerDelegate: class {
    func toolbar(_ toolbar: ToolbarViewController, selectedCategories categories: [Category]) -> Void
    func toolbar(_ toolbar: ToolbarViewController, deselectedCategories categories: [Category]) -> Void
}

class ToolbarViewController: UIViewController {
    
    let toolbarView = ToolbarView()
    var delegate: ToolbarViewControllerDelegate?
    
    var categories = Category.all()
    var selectedCategories = Set<Category>() {
        didSet {
            UIView.animate(withDuration: 0.3) {
                if self.selectedCategories.count == self.categories.count {
                    self.toolbarView.allFiltersButton.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8)
                    self.toolbarView.allFiltersButton.setTitleColor(.white, for: .normal)
                } else {
                    self.toolbarView.allFiltersButton.backgroundColor = .white
                    self.toolbarView.allFiltersButton.setTitleColor(Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8), for: .normal)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolbarView.categoryCV.dataSource = self
        toolbarView.categoryCV.delegate = self
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toolbarView)
        toolbarView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        toolbarView.allFiltersButton.addTarget(self, action: #selector(toggleAllCategories(_:)), for: .touchUpInside)
        
        // cheap way to start with everything selected
//        toggleAllCategories(nil)
    }
    
    @objc private func toggleAllCategories(_ sender: UIButton?) {
        if categories.count == selectedCategories.count {
            selectedCategories.removeAll()
            toolbarView.categoryCV.deselectAllItems(animated: true)
            delegate?.toolbar(self, deselectedCategories: categories)
        } else {
            var indexPath = IndexPath()
            for (index, category) in categories.enumerated() {
                selectedCategories.insert(category)
                indexPath = IndexPath(item: index, section: 0)
                toolbarView.categoryCV.selectItem(at: indexPath, animated: true, scrollPosition: .top)
            }
            delegate?.toolbar(self, selectedCategories: categories)
        }
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
        cell.categoryImageView.image = categoryImage
        
        cell.layer.cornerRadius = cell.bounds.width / 2
        return cell
    }
}

extension ToolbarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let size = CGSize.init(width: height, height: height)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        selectedCategories.insert(category)
        delegate?.toolbar(self, selectedCategories: [category])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        selectedCategories.remove(category)
        delegate?.toolbar(self, deselectedCategories: [category])
    }
}
