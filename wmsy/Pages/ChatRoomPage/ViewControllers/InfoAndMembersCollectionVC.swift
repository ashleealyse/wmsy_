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
    func updateMembers(members: [AppUser])
}

class InfoAndMembersCollectionVC: UIViewController {
    var detailDrawerClosed = false
    private var currentWhim: Whim?
    private var heightConstraint: Constraint? = nil
    
    private var membersCollectionView: UICollectionView!
    var memberInfoView: ChatInfoView!
    
    private var members = [AppUser]() {
        didSet {
            self.delegate?.updateMembers(members: members)
        }
    }
    public var lastMemberID: String? {return members.last?.userID}
    public var inChat = [String: Bool]()
    
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
    
    public func configureWith(_ whim: Whim) {
        self.currentWhim = whim
        self.memberInfoView.shortLabel.text = currentWhim?.title
        self.memberInfoView.longLabel.text = currentWhim?.description
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
            make.height.equalTo(60)
            make.leading.trailing.top.equalTo(self.view)
        }
        
        self.view.addSubview(memberInfoView)
        memberInfoView.snp.makeConstraints { (make) in
            make.height.equalTo(90)
            make.leading.trailing.equalTo(membersCollectionView)
            make.top.equalTo(membersCollectionView.snp.bottom)
           
        }
        
        self.view.snp.makeConstraints { (make) in
           self.heightConstraint = make.bottom.equalTo(memberInfoView.snp.bottom).constraint
        }
        
      
    }
    
    public func new(interestedUser user: AppUser) {
        members.append(user)
        inChat[user.userID] = false
        membersCollectionView.reloadData()
    }
    public func invited(_ user: AppUser) {
        inChat[user.userID] = true
    }
    @objc func toggle() {
        
        // idk if this does anything
        delegate?.toggleUser(user: currentSelectedUser!)
    }
}

extension InfoAndMembersCollectionVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatGuestCell", for: indexPath) as! ChatGuestCollectionViewCell
        if indexPath.row == 0 {
            cell.guestImageView.image = #imageLiteral(resourceName: "wmsyCategoryIcon")
            return cell
        }
        let user = members[indexPath.row - 1]
        let userImagePhotoIDString = user.photoID
        let userImagePhotoIDurl = URL(string: userImagePhotoIDString)
        cell.guestImageView.kf.setImage(with: userImagePhotoIDurl)
        cell.guestImageView.kf.indicatorType = .activity
        cell.isSelected = true
        cell.backgroundColor = (inChat[user.userID] ?? false) ? .blue : .red
        memberInfoView.inviteButton.isHidden = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cvHeight = collectionView.bounds.height * 0.8
        let cellSize = CGSize.init(width: cvHeight, height: cvHeight)
        return cellSize
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.detailDrawerClosed = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)  as! ChatGuestCollectionViewCell
        if indexPath.row == 0 {
            print("whim info")
            memberInfoView.shortLabel.text = currentWhim?.title
            memberInfoView.longLabel.text = currentWhim?.description
            memberInfoView.inviteButton.isHidden = true
            return
        }
        memberInfoView.inviteButton.tag = indexPath.row - 1
        let user = members[indexPath.row - 1]
        currentSelectedUser = user
        memberInfoView.shortLabel.text = user.name
        memberInfoView.longLabel.text = user.bio
        memberInfoView.inviteButton.isHidden = false
        
        let interests = user.interests.filter{$0.whimID == currentWhim?.id}
        if interests[0].inChat {
            memberInfoView.inviteButton.setTitle("Remove", for: .normal)
        } else {
            memberInfoView.inviteButton.setTitle("Invite", for: .normal)
        }
    }

    
   
}

