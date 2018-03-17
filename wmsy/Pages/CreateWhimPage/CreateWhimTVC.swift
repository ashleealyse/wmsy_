//
//  CreateWhimTVC.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CreateWhimTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! WhimCategoryTableViewCell
            categoryCell.categoriesCV.delegate = self as? UICollectionViewDelegate
            categoryCell.categoriesCV.dataSource = self as? UICollectionViewDataSource
            return categoryCell
        case 1:
            let titleCell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! WhimTitleTableViewCell
            return titleCell
        case 2:
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! WhimDescriptionTableViewCell
            return descriptionCell
        case 3:
            let expirationCell = tableView.dequeueReusableCell(withIdentifier: "ExpirationCell", for: indexPath) as! WhimExpirationTableViewCell
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
