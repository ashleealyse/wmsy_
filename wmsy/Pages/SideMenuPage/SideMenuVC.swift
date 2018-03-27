//
//  SideMenuVC.swift
//  wmsy
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit


class SideMenuVC: MenuViewController {
    
    var menuHeader = UIView()
    var newMenu: MenuCollectionViewWrapper!
//    var isChatRoomVisible: Bool = false {
//        didSet {
//            newMenu.menuPagesCollectionView.reloadData()
//            newMenu.dotsView.isChatRoomVisible = isChatRoomVisible
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewisdidloading")
        newMenu = MenuCollectionViewWrapper(frame: menuScreen.frame)
        newMenu.menuPagesCollectionView.dataSource = self
        newMenu.menuPagesCollectionView.delegate = self
        menuScreen.addSubview(menuHeader)
        menuScreen.addSubview(newMenu)
        
        menuHeader.snp.makeConstraints { (make) in
            if let navBarHeight = fromVC?.navigationController?.navigationBar.frame.height,
                let navBarOrigin = fromVC?.navigationController?.navigationBar.frame.origin.y {
                make.height.equalTo(navBarHeight + navBarOrigin)
            } else {
                make.height.equalTo(64)
            }
            make.top.leading.trailing.equalTo(menuScreen)
        }
        newMenu.snp.makeConstraints { (make) in
            make.top.equalTo(menuHeader.snp.bottom)
            make.leading.trailing.bottom.equalTo(menuScreen)
        }
        
        // setup Header
        let touchRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToFeed))
        menuHeader.backgroundColor = Stylesheet.Colors.WMSYKSUPurple
        menuHeader.addGestureRecognizer(touchRecognizer)
    }
    @objc private func goToFeed() {
        if let _ = fromVC as? FeedMapVC {
            closeMenu(sender: self)
        } else {
            switchTo(page: .feedAndMap)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewiswillappearing")
        // TODO: load data from MenuData
        
    }
    
    private var lastContentOffset: CGFloat = 0
}

extension SideMenuVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewWrapper.pageOneIdentifier, for: indexPath) as! MenuProfileView
            cell.signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
            cell.signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
            cell.signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewWrapper.pageTwoIdentifier, for: indexPath) as! MenuWhimsView
            cell.whimsTableView.dataSource = self
            cell.whimsTableView.delegate = self
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewWrapper.pageThreeIdentifier, for: indexPath) as! MenuChatView
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        if scrollView == newMenu.menuPagesCollectionView {
//            print("scrolling collection view")
//            if let pageIndex = newMenu.menuPagesCollectionView.indexPathsForVisibleItems.first {
//                newMenu.currentlyOn(page: pageIndex.item)
//            }
//        }
//        else {
//            print("scrolling table view")
//        }
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == newMenu.menuPagesCollectionView {
            print("scrolling collection view")
            let menuWidth = newMenu.bounds.width
            let offset = newMenu.menuPagesCollectionView.contentOffset.x
            let page = Int(offset / menuWidth)
            print(page)
//            if let pageIndex = newMenu.menuPagesCollectionView.indexPathsForVisibleItems.first {
//                newMenu.currentlyOn(page: pageIndex.item)
//            }
            newMenu.currentlyOn(page: page)
        }
        else {
            print("scrolling table view")
        }
//        if (self.lastContentOffset > scrollView.contentOffset.y) {
//            // move up
//        }
//        else if (self.lastContentOffset < scrollView.contentOffset.y) {
//            // move down
//        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let targetContentOffset = scrollView.contentOffset
////        float pageWidth = (float)self.articlesCollectionView.bounds.size.width;
//        let pageWidth = newMenu.menuPagesCollectionView.bounds.size.width
////        int minSpace = 10;
//        let minSpace: CGFloat = 10
////
////        int cellToSwipe = (scrollView.contentOffset.x)/(pageWidth + minSpace) + 0.5; // cell width + min spacing for lines
//        var cellToSwipe = (scrollView.contentOffset.x) / (pageWidth + minSpace) + 0.5
////        if (cellToSwipe < 0) {
////            cellToSwipe = 0;
////        } else if (cellToSwipe >= self.articles.count) {
////            cellToSwipe = self.articles.count - 1;
////        }
//        if cellToSwipe < 0 {
//            cellToSwipe = 0
//        } else if cellToSwipe >= 2 { // should represent datasource.count
//            cellToSwipe = 1 // should be last index of datasource
//        }
//        newMenu.menuPagesCollectionView.scrollToItem(at: IndexPath.init(row: Int(cellToSwipe), section: 0), at: .left, animated: true)
////        [self.articlesCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:cellToSwipe inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

extension SideMenuVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // Hosts and Guest Chats
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MenuWhimsView.headerIdentifier) as! MenuWhimsHeader
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0..<100:
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuWhimsView.cellIdentifier, for: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuWhimsView.cellIdentifier, for: indexPath) as? MenuWhimsCell else {
            return
        }
//        isChatRoomVisible = true
//        newMenu.currentlyOn(page: 2)
//        let chatRoomIndexPath = IndexPath.init(row: 2, section: 0)
//        newMenu.menuPagesCollectionView.scrollToItem(at: chatRoomIndexPath, at: .right, animated: true)
        if let vc = viewController(for: .chatRoom) as? ChatRoomVCTest {
            let whim = Whim.init(id: "-L8JoE-G-U1uGGYyt4X5", category: "wmsy", title: "Pictures please", description: ":D", hostID: "mdH6CJXxDkYBqhfjjptVnTpMp3g2", hostImageURL: "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/29366139_128316311338085_2672539358371774464_n.jpg?_nc_cat=0&oh=3df47771fb34edb538211510eaa9dff9&oe=5B4431F0", location: "142 West 46th Street New York, NY 10036", long: "-73.9841802790761", lat: "40.7578242106358", duration: 2, expiration: "March 23, 2018 at 7:43:21 PM EDT", finalized: false, timestamp: "March 23, 2018 at 5:43:21 PM EDT", whimChats: [])
            vc.loadAllInitialData(forWhim: whim)
        }
        switchTo(page: .chatRoom)
//        (tabBarController as? MainTabBarVC)?.animateTo(page: .chatRoom, fromViewController: self)
    }
}

