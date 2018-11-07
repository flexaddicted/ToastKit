//
//  ViewController.swift
//  ToastKitDemo
//
//  Created by Boaro Lorenzo on 13/10/2018.
//  Copyright © 2018 Boaro Lorenzo. All rights reserved.
//

import UIKit
import ToastKit

class ViewController: UIViewController {
    
    @IBOutlet var internetSwicth: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set displayOverStatusBar property to true to display the toast over the status bar
        ToastCoordinator.displayOverStatusBar = false
    }
    
    @IBAction func switchDidToggle(_ sender: Any) {
        if internetSwicth.isOn {
            self.view.hideToast()
        } else {
            self.view.showToast(embedding: ToastContentView.create(), duration: 0.4)
        }
    }
}

