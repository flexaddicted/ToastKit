//
//  UIView+ToastKit.swift
//  ToastKit
//
//  Created by Boaro Lorenzo on 13/10/2018.
//  Copyright © 2018 Boaro Lorenzo. All rights reserved.
//

import UIKit

public extension UIView {
    
    private enum AssociatedKey {
        static var Toast = "io.lorenzoboaro.Toast-Kit"
    }
    
    public func showToast(embedding contentView: UIView, duration: TimeInterval = 0.3) {
        
        guard ToastCoordinator.isToastHidden else { return }
        
        ToastCoordinator.toastVisibility = .visible
        
        let toastView = UIView()
        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastView.clipsToBounds = true
        addSubview(toastView)
        
        toastView.addSubview(contentView)
        
        // Constraints for the content view
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: toastView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: toastView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: toastView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: toastView.bottomAnchor)
        ])
        
        toastView.layoutIfNeeded()
        
        let height = toastView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        assert(height > 0, "The content view's height has not been calculated")
        
        // Constraints for the container view
        let chosenTopAnchor = ToastCoordinator.displayOverStatusBar ? topAnchor : safeAreaLayoutGuide.topAnchor
        let topConstraint = toastView.topAnchor.constraint(equalTo: chosenTopAnchor, constant: -height)
        NSLayoutConstraint.activate([
            toastView.leadingAnchor.constraint(equalTo: leadingAnchor),
            toastView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topConstraint
        ])
        
        layoutIfNeeded()
        
        UIView.animate(withDuration: duration) {
            topConstraint.constant = 0
            self.layoutIfNeeded()
        }
        
        objc_setAssociatedObject(self, &AssociatedKey.Toast, toastView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    public func hideToast(duration: TimeInterval = 0.2) {
        
        guard let view = objc_getAssociatedObject(self, &AssociatedKey.Toast) as? UIView else { return }
        
        UIView.animate(withDuration: duration, animations: {
            view.alpha = 0
        }, completion: { _ in
            view.removeFromSuperview()
            ToastCoordinator.toastVisibility = .hidden
        })
    }
}

enum ToastVisibility {
    case visible
    case hidden
}

public final class ToastCoordinator {
    static let shared = ToastCoordinator()
    
    private var _visibility = ToastVisibility.hidden
    static var toastVisibility: ToastVisibility {
        get { return shared._visibility }
        set { shared._visibility = newValue }
    }
    
    static var isToastHidden: Bool {
        return shared._visibility == .hidden
    }
    
    private var _displayOverStatusBar = false
    public static var displayOverStatusBar: Bool {
        get { return shared._displayOverStatusBar }
        set { shared._displayOverStatusBar = newValue }
    }
    
    private init() { }
}
