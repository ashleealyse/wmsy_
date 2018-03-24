//
//  FiltersViewController.swift
//  wmsy
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FiltersVC: UIViewController {

    var filtersView = FiltersView()
    
    let categoryList = categoryTuples
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(filtersView)
        
        self.filtersView.categoriesCV.delegate = self
        self.filtersView.categoriesCV.dataSource = self
        filtersView.categoriesCV.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        print("View will appear")
    }
}



extension FiltersVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! WhimCategoryCollectionViewCell
        let tuple = categoryList[indexPath.row]
//        let indexPath = IndexPath.init(row: 0, section: 0)
        var selectedCategory = tuple
//        cell.categoryImage.image = selectedCategory.1
        self.filtersView.categoryLabel.text = "Filter Whims by: \(selectedCategory.0)"
    }
}

extension FiltersVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCategoryCell", for: indexPath) as! WhimCategoryCollectionViewCell
        let categoryImage = categoryList[indexPath.row].1
        cell.categoryImage.image = categoryImage
        return cell
    }
}



