//
//  CreateWhimViewController.swift
//  wmsy_
//
//  Created by Lynk on 12/9/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit

class CreateWhimViewController: UIViewController {
    
    let createView = CreateView(frame: UIScreen.main.bounds)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        view.addSubview(createView)
        createView.form.delegate = self
        createView.form.dataSource = self
        //createView.form.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    

    

}


extension CreateWhimViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.filter.filterCollection.dataSource = self
            cell.filter.filterCollection.delegate = self
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateCell", for: indexPath) as! CreateCell
            return cell
        default:
            let cell = UITableViewCell()
            cell.backgroundColor = .systemGray6
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
             
        case 5:
            return 100
        default:
            return 100
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
           return 160
        case 5:
           return 0
        default:
            return 40
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var container = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        container.backgroundColor = .systemGray5
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        label.backgroundColor = .systemGray5
        container.addSubviews(subviews: [label])
        container.constrainToAllSides(item: label, sides: ([.bottom,.right, .top],[label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 11)]))
       
        
        switch section {
        case 0:
            label.text = "Category"
        case 1:
            label.text = "Title"
        case 2:
            label.text = "Description"
        case 3:
            label.text = "Location"
        case 4:
            label.text = "Time"
        default:
            return nil
        }
           if section == 0 {
            container = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
            container.backgroundColor = WmsyColors.headerPurple
            let host = UILabel()
            host.textColor = .white
            host.font = UIFont.systemFont(ofSize: 34, weight: .bold)
            host.text = "Host Whim"
            let background = UIView()
            background.backgroundColor = .systemGray5
            container.addSubviews(subviews: [host,background])
            background.addSubviews(subviews: [label])
            background.constrainToAllSides(item: label, sides: (([.bottom,.right],[host.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -17),
            host.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 13),
            host.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 40),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 11)])))
            let fierce = background.heightAnchor.constraint(equalToConstant: 40)
            container.constrainToAllSides(item: background, sides: ([.left,.bottom, .right],[fierce]))
            return container
           }
        return container
    }
   
    
   

}

extension CreateWhimViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        filterCell.filterIcon.image = UIImage(systemName: "plus")
        filterCell.layer.borderWidth = 1
        return filterCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 0)
    }
}
