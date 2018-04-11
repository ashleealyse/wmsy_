//
//  MenuViewController.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "Cell"

class MenuViewController: UIViewController {
    @IBAction func closeMenu(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    var closeButton = UIButton()
    weak var fromVC: UIViewController? {
        didSet {
            print(0)
        }
    }
    var signOutButton = UIButton()
    
    // the menu objects should be added to menuScreen not self.view
    var menuScreen = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuRegion()
        setupCloseMenuRegion()
    }
    
    private func setupMenuRegion() {
        view.addSubview(menuScreen)
        menuScreen.backgroundColor = .white
        menuScreen.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(view)
            make.width.equalTo(view).multipliedBy(MenuHelper.menuWidth)
        }
    }
    private func setupCloseMenuRegion() {
        let panGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(handleClosingGesture(sender:)))
        closeButton.addTarget(self, action: #selector(closeMenu(sender:)), for: .touchUpInside)
        closeButton.addGestureRecognizer(panGestureRecognizer)
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalTo(view)
            make.width.equalTo(view).multipliedBy(1 - MenuHelper.menuWidth)
        }
    }
    
    @objc func signOut() {
        switchTo(page: .login)
    }
    
    // 1
    weak var interactor: Interactor?
    // 2
    @objc func handleClosingGesture(sender: UIPanGestureRecognizer) {
        // 3
        let translation = sender.translation(in: view)
        // 4
        let progress = MenuHelper.calculateProgress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .left
        )
        // 5
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor){
                // 6
                self.dismiss(animated: true, completion: nil)
        }
    }
    
    public func switchTo(page: Page) {
        guard
            let fromVC = fromVC,
            let tabBarVC = (fromVC.tabBarController as? MainTabBarVC)
            else {
                closeMenu(sender: self)
                return
        }
        tabBarVC.animateTo(page: page, fromViewController: self)
    }
    public func viewController(for page: Page) -> UIViewController? {
        return (fromVC?.tabBarController as? MainTabBarVC)?.viewController(for: page)
    }
    
    
}

