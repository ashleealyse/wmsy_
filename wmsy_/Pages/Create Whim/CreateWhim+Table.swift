//
//  CreateWhim+Table.swift
//  wmsy_
//
//  Created by Lynk on 12/17/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit

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
            cell.addBottomBorderWithColor(color: .systemGray, width: 1)

            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.setup(isTitle: true)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! TextFieldCell
            cell.setup(isTitle: false)
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
            cell.addBottomBorderWithColor(color: .systemGray, width: 1)
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
            return 90
        case 1 :
            return 45
        case 2:
            return 100
        case 3:
            return 400
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
           return 200
        case 5:
            return 0
        default:
           return 48
        }
       
        }
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 5 { return nil }
        
        if section != 0  {
            let container = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
            container.backgroundColor = .systemGray6
            let label = UILabel()
                   label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                   label.backgroundColor = .systemGray6
            
            switch section {
            case 1:
                label.text = "Title"
            case 2:
            label.text = "Description"
            
            case 3:
            label.text = "Location"
                
            default:
                label.text = ""
            }
            
            
            container.addSubviews(subviews: [label])
            container.constrainToAllSides(item: label, sides: ([.bottom,.right],[label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 11)]))
            return container
        }
       
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.backgroundColor = .systemGray6
    
            label.text = "Category"
      
         
          let container = UIImageView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 100))
        container.image = UIImage(named: "pbackground")?.darkened()
            //container.backgroundColor = WmsyColors.headerPurple
            let host = UILabel()
            host.textColor = .white
            host.font = UIFont.systemFont(ofSize: 34, weight: .bold)
            host.text = "Host Whim"
            let background = UIView()
            background.backgroundColor = .systemGray6
            container.addSubviews(subviews: [host,background])
            background.addSubviews(subviews: [label])
        background.constrainToAllSides(item: label, sides: (([.right, .bottom],[host.bottomAnchor.constraint(equalTo: background.topAnchor, constant: -17),
            host.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 13),
            host.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 11)])))
            let fierce = background.heightAnchor.constraint(equalToConstant: 30)
            container.constrainToAllSides(item: background, sides: ([.left,.bottom, .right],[fierce]))
            return container
        
    }

}

