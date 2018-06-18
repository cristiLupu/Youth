//
//  TwitterOpener.swift
//  Youth
//
//  Created by User678 on 5/29/18.
//  Copyright © 2018 Lupu Cristian. All rights reserved.
//

import UIKit

/// Responsible to open Twitter App
public class TwitterAppOpener: YouthAppOpener {

    public typealias DataType = String

    public func openApp(withData data: String, completion: AppOpenerActionCompletion) {
        guard let url = URL(string: "twitter://user?screen_name=" + data) else {
            completion(false, .couldNotCreateAppURL)
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
            completion(true, nil)
        } else {
            completion(false, .appNotInstalled)
        }
    }

}
