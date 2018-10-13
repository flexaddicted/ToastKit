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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.view.showToast(embedding: ToastContentView.create(), duration: 0.4)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            self.view.hideToast()
        }
    }
}

