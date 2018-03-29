//
//  MenuPagesVC.swift
//  wmsy
//
//  Created by C4Q on 3/28/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class MenuPagesVC: UIPageViewController {
    
    let pageOne = MenuProfileVC()
    let pageTwo = MenuChatsListVC()
    var menuPages: [UIViewController] {
        return [pageOne, pageTwo]
    }
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = menuPages.first
        {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        configurePageControl()
    }
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: self.view.frame.maxY - 150,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = menuPages.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
}

extension MenuPagesVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//
//        guard let viewControllerIndex = menuPages.index(of: viewController) else { return nil }
//
//        let previousIndex = viewControllerIndex - 1
//
//        guard previousIndex >= 0          else { return menuPages.last }
//
//        guard menuPages.count > previousIndex else { return nil        }
//
//        return menuPages[previousIndex]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
//    {
//        guard let viewControllerIndex = menuPages.index(of: viewController) else { return nil }
//
//        let nextIndex = viewControllerIndex + 1
//
//        guard nextIndex < menuPages.count else { return menuPages.first }
//
//        guard menuPages.count > nextIndex else { return nil         }
//
//        return menuPages[nextIndex]
//    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = menuPages.index(of: pageContentViewController)!
    }
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        configurePageControl()
//        return self.menuPages.count
//    }
//
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
    // MARK: Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = menuPages.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
//            return orderedViewControllers.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
             return nil
        }
        
        guard menuPages.count > previousIndex else {
            return nil
        }
        
        return menuPages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = menuPages.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = menuPages.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
//            return menuPAges.first
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
             return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return menuPages[nextIndex]
    }
    
}


