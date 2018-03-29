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
    func toggleUser(user: AppUser)
}

class InfoAndMembersCollectionVC: UIViewController {
    
    private var membersCollectionView: UICollectionView!
    private var memberInfoView: ChatInfoView!
    
    private var members = [AppUser]() {
        didSet {
            print("members: \(members)")
        }
    }
    private var inChat = [String: Bool]()
    
    private var isShowingInfo = false
    private var currentSelectedUser: AppUser? {
        didSet {
            print("Current Selected User: \(currentSelectedUser?.name ?? "No Current Selected User")")
        }
    }
    
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
        membersCollectionView.register(ChatGuestCollectionViewCell.self, forCellWithReuseIdentifier: "ChatGuestCell")
        membersCollectionView.backgroundColor = .yellow
        
        memberInfoView = ChatInfoView()
        memberInfoView.backgroundColor = .cyan
        
        
        
        
        
        self.view.addSubview(membersCollectionView)
        membersCollectionView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.leading.trailing.top.equalTo(self.view)
        }
        
        self.view.addSubview(memberInfoView)
        memberInfoView.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.leading.trailing.equalTo(membersCollectionView)
            make.top.equalTo(membersCollectionView.snp.bottom)
            make.bottom.equalTo(view)
        }
        
    }
    
    
    
    @objc func toggle() {
        
        // idk if this does anything
        delegate?.toggleUser(user: currentSelectedUser!)
    }
    
    
}

extension InfoAndMembersCollectionVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatGuestCell", for: indexPath) as! ChatGuestCollectionViewCell
        let user = members[indexPath.row]
        let userImagePhotoIDString = user.photoID
        let userImagePhotoIDurl = URL(string: userImagePhotoIDString)
        cell.guestImageView.kf.setImage(with: userImagePhotoIDurl)
        cell.guestImageView.kf.indicatorType = .activity
        cell.isSelected = true
        cell.backgroundColor = (inChat[user.userID] ?? false) ? .blue : .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cvHeight = collectionView.bounds.height
        let cellSize = CGSize.init(width: cvHeight, height: cvHeight)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)  as! ChatGuestCollectionViewCell
        let user = members[indexPath.row]
//        let guestImagePhotoIDString = guest.photoID
//        let guestImagePhotoIDurl = URL(string: guestImagePhotoIDString)
//        cell.guestImageView.kf.setImage(with: guestImagePhotoIDurl)
//        cell.guestImageView.kf.indicatorType = .activity
//        cell.isSelected = true
        currentSelectedUser = user
    }
}

