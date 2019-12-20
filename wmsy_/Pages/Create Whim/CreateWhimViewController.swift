//
//  CreateWhimViewController.swift
//  wmsy_
//
//  Created by Lynk on 12/9/19.
//  Copyright © 2019 Lynk. All rights reserved.
//

import UIKit
import CoreLocation

class CreateWhimViewController: UIViewController {
    
    let createView = CreateView(frame: UIScreen.main.bounds)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        view.addSubview(createView)
        createView.form.delegate = self
        createView.form.dataSource = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKey))
          createView.form.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        //createView.form.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKey() {
        self.view.endEditing(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(CreateWhimViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateWhimViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            print("Notification: Keyboard will show")
            createView.form.setBottomInset(to: keyboardHeight)
    
            createView.form.scrollToNearestSelectedRow(at: .top, animated: true)
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        print("Notification: Keyboard will hide")
        createView.form.setBottomInset(to: 0.0)
    }

}




extension CreateWhimViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        filterCell.filterIcon.image = UIImage(systemName: "plus")
        filterCell.layer.borderWidth = 1
        return filterCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 0)
    }
}

extension CreateWhimViewController: UITextViewDelegate {
    
}
