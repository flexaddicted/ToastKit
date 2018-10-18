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
    
    @IBAction func switchDidToggle(_ sender: Any) {
        if internetSwicth.isOn {
            self.view.hideToast()
        } else {
            self.view.showToast(embedding: ToastContentView.create(), duration: 0.4)
        }
    }
}

