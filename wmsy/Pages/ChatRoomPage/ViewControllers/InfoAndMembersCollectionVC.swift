//
//  InfoAndMembersCollectionVC.swift
//  wmsy
//
//  Created by C4Q on 3/24/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

protocol InfoAndMembersCollectionVCDelegate: class {
    func updateMembers(members: [AppUser])
    func addInterestedUser(_ user: AppUser)
    func removeUser(_ user: AppUser)
}

class InfoAndMembersCollectionVC: UIViewController {

    private var currentWhim: Whim?{
        didSet{
            membersCollectionView?.reloadData()
        }
    }
    private var heightConstraint: Constraint? = nil
    
    private var membersCollectionView: UICollectionView?
    var memberInfoView: ChatInfoView!
    
    private var members = [AppUser]() {
        didSet {
//            self.delegate?.updateMembers(members: members)
        }
    }
    public var lastMemberID: String? {return members.last?.userID}
    public var inChat = [String: Bool]()
    
    private var isShowingInfo = false
    private var currentSelectedUser: AppUser? {
        didSet {
            print("Current Selected User: \(currentSelectedUser?.name ?? "No current user")")
        }
    }
    
    public weak var delegate: InfoAndMembersCollectionVCDelegate?
    
    public func configureWith(members: [AppUser], andPermissions permissions: [String: Bool]) {
        // TODO: get list of members
        self.members = members
        self.inChat = permissions
        membersCollectionView?.reloadData()
    }
    
    public func configureWith(_ whim: Whim) {
        self.currentWhim = whim
        self.memberInfoView.shortLabel.text = currentWhim?.title
        self.memberInfoView.longLabel.text = currentWhim?.description
        
        let userImageString = currentWhim?.hostImageURL
        let userImageUrl = URL(string: userImageString!)
        self.memberInfoView.userImageView.kf.setImage(with: userImageUrl)

        self.memberInfoView.inviteButton.isHidden = true
        self.memberInfoView.showMapButton.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        // setup collectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        membersCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        membersCollectionView?.dataSource = self
        membersCollectionView?.delegate = self
        
        membersCollectionView?.register(ChatGuestCollectionViewCell.self, forCellWithReuseIdentifier: "ChatGuestCell")
        membersCollectionView?.backgroundColor = .white
        
        memberInfoView = ChatInfoView()
        memberInfoView.backgroundColor = .white
        
        self.view.addSubview(membersCollectionView!)
        membersCollectionView?.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.leading.trailing.top.equalTo(self.view)
        }
        
        self.view.addSubview(memberInfoView)
        memberInfoView.snp.makeConstraints { (make) in
            make.height.equalTo(120)
            make.leading.trailing.equalTo(membersCollectionView!)
            make.top.equalTo(membersCollectionView!.snp.bottom)
        }
        
        self.view.snp.makeConstraints { (make) in
           self.heightConstraint = make.bottom.equalTo(memberInfoView.snp.bottom).constraint
        }
        
        memberInfoView.inviteButton.setTitle("Invite", for: .normal)
        memberInfoView.showMapButton.setTitle("Map", for: .normal)
        memberInfoView.inviteButton.addTarget(self, action: #selector(inviteButtonHit), for: .touchUpInside)
        memberInfoView.showMapButton.addTarget(self, action: #selector(showMapButtonHit), for: .touchUpInside)
    }
    
    public func new(interestedUser user: AppUser) {
        members.append(user)
        inChat[user.userID] = false
        self.membersCollectionView?.reloadData()
    }
    public func invited(_ user: AppUser) {
        inChat[user.userID] = true
    }
    public func removed(_ user: AppUser) {
        guard let index = members.index(where: {$0.userID == user.userID}) else {
            print("wasn't a user in here")
            fatalError()
        }
        members.remove(at: index)
        inChat[user.userID] = nil
    }
    
    @objc func showGuestsTableView() {
        let chatGuestsTVC = ChatGuestsTableVC(members: members, inChat: inChat)
        present(chatGuestsTVC, animated: true, completion: nil)
    }
    
    @objc func inviteButtonHit() {
        guard
            let user = currentSelectedUser,
            let inChat = inChat[user.userID] else {
                return
        }
        if inChat {
            delegate?.removeUser(user)
        } else {
            delegate?.addInterestedUser(user)
            memberInfoView.inviteButton.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            memberInfoView.inviteButton.setTitle("Remove", for: .normal)
        }
        self.membersCollectionView!.reloadData()
    }
    
    @objc func showMapButtonHit() {
        print("Show this Whim on the map")
    }
}

extension InfoAndMembersCollectionVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatGuestCell", for: indexPath) as! ChatGuestCollectionViewCell
        if indexPath.row == 0 {
            guard self.currentWhim != nil else{return cell}
            let userImageString = currentWhim?.hostImageURL
            let userImageUrl = URL(string: userImageString!)
            cell.guestImageView.kf.setImage(with: userImageUrl)
            cell.guestImageView.backgroundColor = .white
            cell.guestImageView.alpha = 1.0
            return cell
        }
        let user = members[indexPath.row - 1]
        let userImagePhotoIDString = user.photoID
        let userImagePhotoIDurl = URL(string: userImagePhotoIDString)
        cell.guestImageView.kf.setImage(with: userImagePhotoIDurl)
        cell.guestImageView.kf.indicatorType = .activity
        cell.guestImageView.alpha = (inChat[user.userID] ?? false) ? 1.0 : 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cvHeight = collectionView.bounds.height * 0.8
        let cellSize = CGSize.init(width: cvHeight, height: cvHeight)
        return cellSize
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)  as! ChatGuestCollectionViewCell

        if indexPath.row == 0 {
            print("whim info")
            currentSelectedUser = nil
            let userImageString = currentWhim?.hostImageURL
            let userImageUrl = URL(string: userImageString!)
            memberInfoView.userImageView.kf.setImage(with: userImageUrl)
            memberInfoView.shortLabel.text = currentWhim?.title
            memberInfoView.longLabel.text = currentWhim?.description
            memberInfoView.inviteButton.isHidden = true
            memberInfoView.showMapButton.isHidden = false
            cell.guestImageView.backgroundColor = .white
        } else {
            currentSelectedUser = members[indexPath.row - 1]
            cell.guestImageView.alpha = (inChat[(currentSelectedUser?.userID)!] ?? false) ? 1.0 : 0.5
            memberInfoView.shortLabel.text = currentSelectedUser?.name
            memberInfoView.longLabel.text = currentSelectedUser?.bio
            memberInfoView.inviteButton.isHidden = false
            memberInfoView.showMapButton.isHidden = true
            let userImageString = currentSelectedUser?.photoID
            let userImageUrl = URL(string: userImageString!)
            memberInfoView.userImageView.kf.setImage(with: userImageUrl)

            if inChat[currentSelectedUser!.userID]! {
                memberInfoView.inviteButton.setTitle("Remove", for: .normal)
                memberInfoView.inviteButton.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            } else {
                memberInfoView.inviteButton.setTitle("Invite", for: .normal)
                memberInfoView.inviteButton.backgroundColor = Stylesheet.Colors.WMSYKSUPurple.withAlphaComponent(0.8)
            }
        }
        collectionView.reloadData()
    }
}

