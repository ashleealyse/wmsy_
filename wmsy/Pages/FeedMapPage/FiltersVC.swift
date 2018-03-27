//
//  FiltersViewController.swift
//  wmsy
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

//import UIKit


//protocol setFiltersVCDelegate: class {
//    func changeListOf(whims: [Whim])
//}


//class FiltersVC: UIViewController {

//    var filtersView = FiltersView()
    
//    let categoryList = categoryTuples
    
//    var feedWhims: [Whim] = [] {
//        didSet {
//            print("FiltersVC feedWhims: \(feedWhims)")
//            delegate?.changeListOf(whims: feedWhims)
//        }
//    }
    
//    weak var delegate: setFiltersVCDelegate?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.addSubview(filtersView)
        
//        self.filtersView.categoriesCV.delegate = self
//        self.filtersView.categoriesCV.dataSource = self
//        filtersView.categoriesCV.reloadData()
//
//        filtersView.clearSearchButton.addTarget(self, action: #selector(clearSearch), for: .touchUpInside)
        
//        let distances = ["0.5", "1.0", "5.0", "10.0"]
////        let customSC = UISegmentedControl(items: distances)
////        customSC.selectedSegmentIndex = 0
//        filtersView.distanceSegmentedControl = UISegmentedControl(items: distances)
//        filtersView.distanceSegmentedControl.selectedSegmentIndex = 0
//        filtersView.distanceSegmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
//        filtersView.distanceSegmentedControl.tintColor = Stylesheet.Colors.WMSYShadowBlue
//        filtersView.distanceSegmentedControl.backgroundColor = Stylesheet.Colors.WMSYKSUPurple
        
//        self.view.addSubview(filtersView.distanceSegmentedControl)
//        filtersView.distanceSegmentedControl.setTitle("0.5", forSegmentAt: 0)
//        filtersView.distanceSegmentedControl.setTitle("1.0", forSegmentAt: 1)
//        filtersView.distanceSegmentedControl.setTitle("5.0", forSegmentAt: 2)
//        filtersView.distanceSegmentedControl.setTitle("10.0", forSegmentAt: 3)
    }
    
//    @objc func indexChanged(_ sender: AnyObject) {
//        switch filtersView.distanceSegmentedControl.selectedSegmentIndex {
//        case 0:
//            print("0.5 miles")
//        case 1:
//            print("1.0 miles")
//        case 2:
//            print("5.0 miles")
//        case 3:
//            print("10.0 miles")
//        default:
//            break
//
//        }
//    }
    
//    @objc func clearSearch() {
//        print("need to add functionality to clear the search category")
//
//    }
    
    
}



//extension FiltersVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! WhimCategoryCollectionViewCell
//        let tuple = categoryList[indexPath.row]
//        var selectedCategory = tuple
//        self.filtersView.categoryLabel.text = "Filter Whims by: \(selectedCategory.0)"
//        DBService.manager.getCategoryWhims(fromCategory: selectedCategory.0) { (whims) in
//            self.feedWhims = whims
//        }
//    }
//}
//
//extension FiltersVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return categoryList.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCategoryCell", for: indexPath) as! WhimCategoryCollectionViewCell
//        let categoryImage = categoryList[indexPath.row].1
//        cell.categoryImage.image = categoryImage
//        return cell
//    }
//}
//
//
//
