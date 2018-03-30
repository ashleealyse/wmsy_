//
//  SideMenuVC.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth

class SideMenuVC: MenuViewController {
    
    private var hostedWhims = [Whim]()
    private var guestWhims = [Whim]()
    private var pendingInterests = [Interest]()
    
    let editBioVC = PopUpTextViewVC()
    let navVC = MenuNavigationBarVC()
    let menuPagesVC = MenuPagesVC.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    let info = MenuData.manager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.add(navVC)
        self.add(menuPagesVC)
        
        navVC.view.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self.menuScreen)
        }
        menuPagesVC.view.snp.makeConstraints { (make) in
            make.top.equalTo(navVC.view.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.menuScreen)
        }
        
        //nav
        navVC.feedButton.addTarget(self, action: #selector(goToFeed), for: .touchUpInside)
        
        // profile
        if let appUser = AppUser.currentAppUser {
            menuPagesVC.pageOne.configureWith(appUser: appUser)
        }
        menuPagesVC.pageOne.profileView.signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        menuPagesVC.pageOne.profileView.editBioButton.addTarget(self, action: #selector(editBio), for: .touchUpInside)
        menuPagesVC.pageOne.profileView.bioTextView.delegate = self
        
        
        // whim list
        menuPagesVC.pageTwo.delegate = self
        let hostedWhims = info.hostedWhims
        let guestWhims = info.guestWhims
        let pendingInterests = info.pendingInterests
        menuPagesVC.pageTwo.configureWith(hostedWhims: hostedWhims, guestWhims: guestWhims, pendingInterests: pendingInterests)
    }
    
    @objc private func editBio() {
//        editBioVC.modalTransitionStyle = .crossDissolve
//        self.present(editBioVC, animated: true, completion: nil)
        let tv = menuPagesVC.pageOne.profileView.bioTextView
        tv.isEditable = true
        tv.becomeFirstResponder()
        
    }
    @objc private func goToFeed() {
        if let _ = fromVC as? FeedMapVC {
            closeMenu(sender: self)
        } else {
            switchTo(page: .feedAndMap)
        }
    }
    override func signOut() {
        super.signOut()
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}

extension SideMenuVC: MenuChatsListVCDelegate {
    func didSelect(whim: Whim) {
        if let vc = viewController(for: .chatRoom) as? ChatRoomVCTest {
            if whim.id != vc.whimID {
                vc.loadAllInitialData(forWhim: whim, completion: {
                    if let _ = self.fromVC as? ChatRoomVCTest {
                        self.closeMenu(sender: self)
                    } else {
                        self.switchTo(page: .chatRoom)
                    }
                })
            } else {
                if let _ = fromVC as? ChatRoomVCTest {
                    closeMenu(sender: self)
                } else {
                    switchTo(page: .chatRoom)
                }
            }
        } else {
            
        }
    }
}

extension SideMenuVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            let text = textView.text!
            DBService.manager.updateBio(text, forUser: AppUser.currentAppUser!)
            return false
        }
        return true
    }
}
