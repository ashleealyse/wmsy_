//
//  MenuedViewController.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
//import MaterialComponents

class MenuedViewController: UIViewController {
    
//    var viewIsVisible: Bool = true
//    override var prefersStatusBarHidden: Bool {
//        return !viewIsVisible
//    }
    let interactor = Interactor()
//    let headerViewController = MDCFlexibleHeaderViewController()
    
    @IBAction func openMenu(sender: AnyObject) {
        //        performSegueWithIdentifier("openMenu", sender: nil)
        let menu = SideMenuVC()
        menu.transitioningDelegate = self
        menu.interactor = interactor
        menu.fromVC = self
        present(menu, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        let screenGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanGesture(sender:)))
        screenGesture.edges = .left
        view.addGestureRecognizer(screenGesture)
        
        view.backgroundColor = .blue
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(openMenu(sender:)))
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        viewIsVisible = true
//        UIView.animate(withDuration: 0.5) {
//            self.setNeedsStatusBarAppearanceUpdate()
//        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        viewIsVisible = true
//        UIView.animate(withDuration: 0.1) {
//                self.setNeedsStatusBarAppearanceUpdate()
//        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        viewIsVisible = false
//        UIView.animate(withDuration: 0.5) {
//            self.setNeedsStatusBarAppearanceUpdate()
//        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        viewIsVisible = false
//        UIView.animate(withDuration: 0.1) {
//            self.setNeedsStatusBarAppearanceUpdate()
//        }
    }
    
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .right)
        
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor){
                //                self.performSegueWithIdentifier("openMenu", sender: nil)
                let menu = SideMenuVC()
                menu.transitioningDelegate = self
                menu.interactor = interactor
                menu.fromVC = self
                present(menu, animated: true, completion: nil)
        }
    }
    
//    private func switchTo(page: Page) {
//        (fromVC?.tabBarController as? MainTabBarController)?.animateTo(page: page, fromViewController: self)
//    }
}

extension MenuedViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

