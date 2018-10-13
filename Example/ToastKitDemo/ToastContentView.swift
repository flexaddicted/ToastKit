//
//  ToastContentView.swift
//  ToastKitDemo
//
//  Created by Boaro Lorenzo on 13/10/2018.
//  Copyright © 2018 Boaro Lorenzo. All rights reserved.
//

import UIKit

class ToastContentView: UIView {
    
    static func create() -> UIView {
        let nib = UINib(nibName: "ToastContent", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
