//
//  UIView.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for(index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }

    func removeAllSubviews() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }

    func strechOnSuperview() {
        if let superview = self.superview {
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        }
    }

    func strechOnSafeArea() {
        if #available(iOS 11, *) {
            if let guides = self.superview?.safeAreaLayoutGuide {
                topAnchor.constraint(equalTo: guides.topAnchor).isActive = true
                leadingAnchor.constraint(equalTo: guides.leadingAnchor).isActive = true
                trailingAnchor.constraint(equalTo: guides.trailingAnchor).isActive = true
                bottomAnchor.constraint(equalTo: guides.bottomAnchor).isActive = true
            }
        } else {
            if let superview = self.superview {
                topAnchor.constraint(equalTo: superview.topAnchor, constant: UIApplication.shared.statusBarFrame.size.height).isActive = true
                leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
                trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
                bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            }
        }
    }

    func pinToTop(height: CGFloat) {
        if #available(iOS 11, *) {
            if let guides = self.superview?.safeAreaLayoutGuide {
                topAnchor.constraint(equalTo: guides.topAnchor).isActive = true
                leadingAnchor.constraint(equalTo: guides.leadingAnchor).isActive = true
                trailingAnchor.constraint(equalTo: guides.trailingAnchor).isActive = true
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        } else {
            if let superview = self.superview {
                topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
                leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
                trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
    }

    func centerOnSuperview() {
        if let superview = self.superview {
            let horizontalCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: 1.0, constant: 0)
            superview.addConstraint(horizontalCenterConstraint)
            let verticalCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: superview, attribute: .centerY, multiplier: 1.0, constant: 0)
            superview.addConstraint(verticalCenterConstraint)
        }
    }
}
