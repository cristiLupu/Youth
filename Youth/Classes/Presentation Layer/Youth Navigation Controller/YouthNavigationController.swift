//
//  YouthNavigationController.swift
//  Youth
//
//  Created by Lupu Cristian on 5/20/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

/// Main navigation controller of app
public final class YouthNavigationController: UINavigationController {

    public convenience init(initialViewController: UIViewController) {
        self.init(navigationBarClass: YouthNavigationBar.self, toolbarClass: nil)
        viewControllers = [initialViewController]
    }

}
