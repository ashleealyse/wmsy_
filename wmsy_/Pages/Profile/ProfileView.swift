//
//  ProfileView.swift
//  wmsy_
//
//  Created by Lynk on 12/9/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit




class ProfileView: UIView {
    lazy var persistentBar: UIView = {
        let v = UIView()
        v.backgroundColor = WmsyColors.headerPurple
        return v
    }()
    
    lazy var persistentUserName: UILabel = {
        let v = UILabel()
        v.text = "@Username"
        v.textAlignment = .center
        v.textColor = .white
        v.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        return v
    }()
    
    
    lazy var gallery: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(FilterCell.self, forCellWithReuseIdentifier: "GalleryCell")
        cv.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProfileHeader")
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .systemGray6
        cv.bounces = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    private var header: ProfileHeader?
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder:coder)
           commonInit()
       }
       
       func commonInit() {
        backgroundColor = .systemGray6
        addSubviews(subviews: [gallery])
        //persistentBar.addSubviews(subviews: [persistentUserName])
        //constrainPersistenceBar()
        constrainGallery()
       }
    
    func constrainGallery() {
        constrainToAllSides(item: gallery, sides: ([.left,.right,.bottom,.top],[]))
    }

    
    func constrainPersistenceBar() {
        constrainToAllSides(item: persistentBar, sides: ([.top,.left,.right],[persistentBar.heightAnchor.constraint(equalToConstant: 50)]))
       
        persistentBar.constrainToAllSides(item: persistentUserName, sides: ([.left,.right],[persistentUserName.centerXAnchor.constraint(equalTo: persistentBar.centerXAnchor),persistentUserName.centerYAnchor.constraint(equalTo: persistentBar.centerYAnchor)]))
        
    }
}


extension ProfileView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! FilterCell
        cell.filterIcon.backgroundColor = WmsyColors.headerPurple
        
      
        cell.filterIcon.image = [UIImage(named: "test3"),UIImage(named: "test1"),UIImage(named: "test2") ].randomElement() as! UIImage
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let leftAndRightPaddings: CGFloat = 30.0
           let numberOfItemsPerRow: CGFloat = 2.0

           let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
           return CGSize(width: width, height: width) // You can change width and height here as pr your requirement
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProfileHeader", for: indexPath) as! ProfileHeader
        return view
    }
  
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: frame.width, height: frame.height * 0.7)
    }
    
    
    
}
