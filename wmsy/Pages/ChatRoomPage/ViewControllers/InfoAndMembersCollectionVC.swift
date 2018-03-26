//
//  InfoAndMembersCollectionVC.swift
//  wmsy
//
//  Created by C4Q on 3/24/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

protocol InfoAndMembersCollectionVCDelegate: class {
    
}

class InfoAndMembersCollectionVC: UIViewController {
    
    private var membersCollectionView: UICollectionView!
    private var members = [AppUser]()
    private var inChat = [String: Bool]()
    
    private var isShowingInfo = false
    
    public weak var delegate: InfoAndMembersCollectionVCDelegate?
    
    public func configureWith(members: [AppUser], andPermissions permissions: [String: Bool]) {
        // TODO: get list of members
        self.members = members
        self.inChat = permissions
        membersCollectionView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        // setup collectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        membersCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        membersCollectionView.dataSource = self
        membersCollectionView.delegate = self
        
        self.view.addSubview(membersCollectionView)
        membersCollectionView.snp.makeConstraints { (make) in
            make.height.equalTo(150)
            make.edges.equalTo(self.view)
        }
    }
    
    
}

extension InfoAndMembersCollectionVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        let user = members[indexPath.row]
        cell.backgroundColor = (inChat[user.userID] ?? false) ? .blue : .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cvHeight = collectionView.bounds.height
        let cellSize = CGSize.init(width: cvHeight, height: cvHeight)
        return cellSize
    }
    
}

