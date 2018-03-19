//
//  CreateWhimTVC.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CreateWhimTVC: UITableViewController {
    
    let categoryList = categoryTuples
    let hoursList = hoursOfTwentyFour

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.allowsSelection = false
        self.tableView.bounces = false
        self.tableView.separatorColor = Stylesheet.Colors.WMSYOuterSpace
        self.tableView.register(WhimCategoryTableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        self.tableView.register(WhimTitleTableViewCell.self, forCellReuseIdentifier: "TitleCell")
        self.tableView.register(WhimDescriptionTableViewCell.self, forCellReuseIdentifier: "DescriptionCell")
        self.tableView.register(WhimExpirationTableViewCell.self, forCellReuseIdentifier: "ExpirationCell")
        self.tableView.register(WhimLocationTableViewCell.self, forCellReuseIdentifier: "LocationCell")
        self.tableView.register(HostAWhimButtonTableViewCell.self, forCellReuseIdentifier: "ButtonCell")
        
        
        // Uncomment the followinwg line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    override func viewWillAppear(_ animated: Bool) {
        view.setNeedsLayout()
        view.layoutIfNeeded()
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80.0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! WhimCategoryTableViewCell
            categoryCell.categoriesCV.delegate = self
            categoryCell.categoriesCV.dataSource = self
            
            return categoryCell
        case 1:
            let titleCell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! WhimTitleTableViewCell
            titleCell.titleTextfield.tag = 0
            titleCell.titleTextfield.delegate = self
            titleCell.charactersRemainingLabel.tag = 0
            
            return titleCell
        case 2:
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! WhimDescriptionTableViewCell
            descriptionCell.descriptionTextfield.tag = 1
            descriptionCell.descriptionTextfield.delegate = self
            descriptionCell.charactersRemainingLabel.tag = 1
            return descriptionCell
        case 3:
            let expirationCell = tableView.dequeueReusableCell(withIdentifier: "ExpirationCell", for: indexPath) as! WhimExpirationTableViewCell
            
            expirationCell.hourPickerView.dataSource = self
            expirationCell.hourPickerView.delegate = self
            return expirationCell
        case 4:
            let locationCell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! WhimLocationTableViewCell
            return locationCell
        case 5:
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! HostAWhimButtonTableViewCell
            return buttonCell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
}

extension CreateWhimTVC: UITextFieldDelegate {
    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textFieldToChange.tag {
        case 0:
            // Title TextField
            
            // limit characters
            let characterCountLimit = 100
            
            // We need to figure out how many characters would be in the string after the change happens
            let startingLength = textFieldToChange.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace = range.length
            
            let newLength = startingLength + lengthToAdd - lengthToReplace
            
//            charactersRemainingLabel.text = "\(newLength) characters remaining"
            return newLength <= characterCountLimit
            
        case 1:
            // Description TextField
            
            // limit characters
            let characterCountLimit = 200
            
            // We need to figure out how many characters would be in the string after the change happens
            let startingLength = textFieldToChange.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace = range.length
            
            let newLength = startingLength + lengthToAdd - lengthToReplace
            
//            charactersRemainingLabel.text = "\(newLength) characters remaining"
            return newLength <= characterCountLimit
        default:
            // Description TextField
            
            // limit characters
            let characterCountLimit = 200
            
            // We need to figure out how many characters would be in the string after the change happens
            let startingLength = textFieldToChange.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace = range.length
            
            let newLength = startingLength + lengthToAdd - lengthToReplace
            
//            charactersRemainingLabel.text = "\(newLength) characters remaining"
            return newLength <= characterCountLimit
            
        }
    }
}

extension CreateWhimTVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! WhimCategoryCollectionViewCell
        
        // toggle only one at a time.
//        cell.toggleColor()
        
        let tuple = categoryList[indexPath.row]
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        
        let categoryTableViewCell = tableView.cellForRow(at: indexPath) as! WhimCategoryTableViewCell
        
        var selectedCategory = tuple
        
        categoryTableViewCell.categoryLabel.text = "Category: \(selectedCategory.0)"
    }
    
    

    
}

extension CreateWhimTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! WhimCategoryCollectionViewCell
        let categoryImage = categoryList[indexPath.row].1
        cell.categoryImage.image = categoryImage
        return cell
    }
    
}


extension CreateWhimTVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hoursList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hoursList[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let hour = hoursList[row]
        let hourIndex = row
//        switch hourIndex {
//        case 0:
//            print("1 hour until Whim expires")
//        default:
//            print("\(hourIndex + 1) hours until Whim expires")
//        }
    }
    
}

