//
//  AddWhimLocationViewController.swift
//  wmsy
//
//  Created by C4Q on 3/21/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

protocol setAddressDelegate: class {
    func setAddress(atAddress: String)
}

class AddWhimLocationViewController: UIViewController {

    weak var delegate: setAddressDelegate?
    
    var addWhimLocationView = AddWhimLocationView()
    var selectedLocation: String = "" {
        didSet {
            addWhimLocationView.locationLabel.text = "Selected Address: \(selectedLocation)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addWhimLocationView)
        
        addWhimLocationView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        
            
            
        addWhimLocationView.selectButton.addTarget(self, action: #selector(selectLocation), for: .touchUpInside)
        
        configureNavBar()
        
    }
    
    @objc func selectLocation() {
        // replace this with the pin point location from map
        selectedLocation = "123 Qwerty St"
        
        
        print("Location Selected: \(selectedLocation)")
        
        delegate?.setAddress(atAddress: selectedLocation)
        // take the selectedLocation and bring it to the CreateWhimTVC
        navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureNavBar() {
        navigationItem.title = "Choose Whim Location"
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
