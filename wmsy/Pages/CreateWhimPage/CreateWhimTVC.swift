//
//  CreateWhimTVC.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class CreateWhimTVC: UITableViewController {
   
    
    let categoryList = categoryTuples
    let hoursList = hoursOfTwentyFour
    var whimCategory = ""
    var whimTitle = ""
    var whimDescription = ""
    var whimDuration = 0
    var whimLocation = ""
    var whimLong = ""
    var whimLat = ""
    var whimHostImageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapped))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.allowsSelection = false
        self.tableView.bounces = false
//        self.tableView.separatorStyle = .singleLine
//        self.tableView.separatorColor = Stylesheet.Colors.WMSYOuterSpace
        self.tableView.register(WhimColorViewTableViewCell.self, forCellReuseIdentifier: "ColorViewCell")
        self.tableView.register(WhimCategoryTableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        self.tableView.register(WhimTitleTableViewCell.self, forCellReuseIdentifier: "TitleCell")
        self.tableView.register(WhimDescriptionTableViewCell.self, forCellReuseIdentifier: "DescriptionCell")
        self.tableView.register(HostAWhimButtonTableViewCell.self, forCellReuseIdentifier: "ButtonCell")
        self.tableView.register(WhimExpirationTableViewCell.self, forCellReuseIdentifier: "ExpirationCell")
        self.tableView.register(WhimLocationTableViewCell.self, forCellReuseIdentifier: "LocationCell")
        self.tableView.register(CancelCreateWhimTableViewCell.self, forCellReuseIdentifier: "CancelButton")

        DBService.manager.getAppUser(fromID: (AuthUserService.manager.getCurrentUser()?.uid)!) { (user) in
            self.whimHostImageURL = user!.photoID
        }

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false 
    }
    
    @objc func tapped(){
        let titleCell = self.tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as? WhimTitleTableViewCell
        let descriptionCell = self.tableView.cellForRow(at: IndexPath.init(row: 3, section: 0)) as? WhimDescriptionTableViewCell
        titleCell?.titleTextfield.resignFirstResponder()
        descriptionCell?.descriptionTextView.resignFirstResponder()
    }
    
    
    
    
    private func configureNavBar() {
        navigationItem.title = "Host a Whim"
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.isHidden = true
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: "ColorViewCell", for: indexPath) as! WhimColorViewTableViewCell
            return categoryCell
        case 1:
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! WhimCategoryTableViewCell
            categoryCell.categoriesCV.delegate = self
            categoryCell.categoriesCV.dataSource = self
            return categoryCell
        case 2:
            let titleCell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! WhimTitleTableViewCell
            titleCell.titleTextfield.delegate = self
            titleCell.charactersRemainingLabel.tag = 0
            return titleCell
        case 3:
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! WhimDescriptionTableViewCell
            descriptionCell.descriptionTextView.delegate = self
            descriptionCell.charactersRemainingLabel.tag = 1
            return descriptionCell
        case 4:
            let locationCell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! WhimLocationTableViewCell
            
            locationCell.selectLocationButton.addTarget(self, action: #selector(selectLocation), for: .touchUpInside)
            if whimLocation == "" {
                locationCell.selectLocationButton.setTitle("Drop Pin", for: .normal)
            } else {
                locationCell.selectLocationButton.setTitle(whimLocation, for: .normal)
            }
            return locationCell
        case 5:
            let expirationCell = tableView.dequeueReusableCell(withIdentifier: "ExpirationCell", for: indexPath) as! WhimExpirationTableViewCell
            expirationCell.hourPickerView.dataSource = self
            expirationCell.hourPickerView.delegate = self
            return expirationCell
        case 6:
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath) as! HostAWhimButtonTableViewCell
            buttonCell.hostButton.addTarget(self, action: #selector(collectInputs), for: .touchUpInside)
            
            return buttonCell
        case 7:
            let cancelButton = tableView.dequeueReusableCell(withIdentifier: "CancelButton", for: indexPath) as! CancelCreateWhimTableViewCell
            cancelButton.cancelButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
        
            return cancelButton
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    @objc func selectLocation() {
        let addWhimVC = AddWhimLocationViewController()
        addWhimVC.modalPresentationStyle = .overCurrentContext
        addWhimVC.modalTransitionStyle = .crossDissolve
        self.present(addWhimVC, animated: false, completion: nil)
        addWhimVC.delegate = self
        print("open modal map to select a pin location for private address")
    }
    
    
    @objc func dismissButtonClicked() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func collectInputs() {
        
        if whimCategory != "", whimTitle != "", whimDescription != "", whimLocation != "", whimLong != "", whimLat != "", whimDuration != 0 {
            DBService.manager.addWhimWith(category: whimCategory, title: whimTitle, description: whimDescription, hostImageURL: whimHostImageURL, location: whimLocation, long: whimLong, lat: whimLat, duration: whimDuration)
            
            print("New Whim - Title: \(whimTitle), Description: \(whimDescription), Category: \(whimCategory), Location: \(whimLocation), Long: \(whimLong), Lat: \(whimLat) Duration: \(whimDuration)")
            
          
            dismissButtonClicked()
            
        } else {
            print("Missing item -  Title: \(whimTitle), Description: \(whimDescription), Category: \(whimCategory), Location: \(whimLocation), Duration: \(whimDuration)")
            
            let missingFieldAlert = Alert.create(withTitle: "Missing a Field", andMessage: "OK", withPreferredStyle: .alert)
            Alert.addAction(withTitle: "Cancel", style: .cancel, andHandler: nil, to: missingFieldAlert)
            self.present(missingFieldAlert, animated: true, completion: nil)
            return }
    }
}

extension CreateWhimTVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    func textField(_ textFieldToChange: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        

            // Title TextField
            let characterCountLimit = 34
            let startingLength = textFieldToChange.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace = range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            
            let indexPath = IndexPath.init(row: 2, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! WhimTitleTableViewCell
            cell.charactersRemainingLabel.text = "\(newLength)/35"
            
            return newLength <= characterCountLimit

    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        whimTitle = textField.text!
    }
}


extension CreateWhimTVC: UITextViewDelegate {
    func textViewDidBeginEditing (_ textView: UITextView) {
        if textView.isFirstResponder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        whimDescription = textView.text
    }

    
    func textViewDidEndEditing (_ textView: UITextView) {
        if textView.text.isEmpty || textView.text == "" {
            textView.textColor = .gray
            textView.text = "Describe your Whim"
        }
        textView.isScrollEnabled = false
        textView.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterCountLimit = 99
        let startingLength = textView.text?.count ?? 0
        let lengthToAdd = text.count
        let lengthToReplace = range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        
        let indexPath = IndexPath.init(row: 3, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! WhimDescriptionTableViewCell
        cell.charactersRemainingLabel.text = "\(newLength)/100"
        
//        if(text == "\n") {
//            textView.resignFirstResponder()
//        }
        
        return newLength <= characterCountLimit
    }
}

extension CreateWhimTVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! WhimCategoryCollectionViewCell
        let tuple = categoryList[indexPath.row]
        let indexPath = IndexPath.init(row: 1, section: 0)
        let categoryTableViewCell = tableView.cellForRow(at: indexPath) as! WhimCategoryTableViewCell
        var selectedCategory = tuple
        categoryTableViewCell.categoryLabel.text = "Category: \(selectedCategory.0)"
        whimCategory = selectedCategory.0
    }
}

extension CreateWhimTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
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
        
        whimDuration = hourIndex
    }

    
}

extension CreateWhimTVC: setAddressDelegate{
    
    func setAddress(atAddress: String) {
        self.whimLocation = atAddress
        self.tableView.reloadData()
        
    }
    func setCoordinates(long: String, lat: String) {
        self.whimLong = long
        self.whimLat = lat
    }
    
    
}
