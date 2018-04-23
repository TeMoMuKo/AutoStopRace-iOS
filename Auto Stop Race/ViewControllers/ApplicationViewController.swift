//
//  ApplicationViewController.swift
//  Auto Stop Race
//
//  Created by RI on 23/04/2018.
//  Copyright © 2018 Torianin. All rights reserved.
//

import UIKit

class ApplicationViewController {

    public private(set) weak var rootViewController: UIViewController?

    public private(set) var controllers = [UIViewController]()

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    func setMainController(viewController: UIViewController) {
        if let rootViewController = self.rootViewController {
            controllers.append(viewController)
            rootViewController.addChildViewController(viewController)
            rootViewController.view.addSubview(viewController.view)
        }
    }

    deinit {
        if self.rootViewController != nil {
            for controller in controllers {
                controller.view.removeFromSuperview()
                controller.removeFromParentViewController()
            }
            controllers.removeAll()
            self.rootViewController = nil
        }
    }

    func present(_ viewController: UIViewController, animated: Bool = true) {
        rootViewController?.present(viewController, animated: animated)
    }
}
