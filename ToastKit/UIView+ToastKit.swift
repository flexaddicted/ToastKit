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
        
        // constraints for the content view
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: toastView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: toastView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: toastView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: toastView.bottomAnchor)
        ])
        
        toastView.layoutIfNeeded()
        
        let height = toastView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        assert(height > 0, "The content view's height has not been calculated")
        
        // constaints for the container view
        let topConstraint = toastView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -height)
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
        }) { _ in
            view.removeFromSuperview()
            ToastCoordinator.toastVisibility = .hidden
        }
    }
}

enum ToastVisibility {
    case visible
    case hidden
}

final class ToastCoordinator {
    
    static let shared = ToastCoordinator()
    
    fileprivate static var toastVisibility: ToastVisibility {
        get { return shared.visibility }
        set { shared.visibility = newValue }
    }
    
    fileprivate static var isToastHidden: Bool {
        return shared.visibility == .hidden
    }
    
    private var visibility = ToastVisibility.hidden
    
    private init() { }
}
